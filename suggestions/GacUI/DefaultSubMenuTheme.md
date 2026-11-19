# Ordinary submenus retain the theme that created them

An existing popup can keep its old frame and background while its rows adopt the new theme.

## Repro

Start `FullControlTest /D2D /Hosted` with DarkSkin in a build that leaves the stock
popup template on existing menus. Switch to Win7Skin in **Window Manager**. Open the
view selector on **List / ListView**, then **File / Save as** on
**Control / Document Editor (Toolstrip)**. Compare these with a freshly opened editor
context menu.

The File menu and combo retained DarkSkin’s `#1B1B1C` background and `#333337` border.
The menu rows already used Win7Skin’s black text, transparent resting face and hover
colors. The first context-menu level adopted the selected theme. Unregistering all
four theme names and then registering Win7Skin or Win8Skin reproduced the stale popup
in both skins.

## Workaround

Register the ordinary popup template in the theme’s `Menu` slot and leave the owner’s
`SubMenuTemplate` empty. Applications can still pass an explicit template.
FullControlTest unregisters its four theme names and registers the selected one. It
clears the copied factory on existing ordinary DarkSkin menu windows, which then
resolve through `ThemeName::Menu` at refresh.
[Showcase switcher](../../Test/FullControlTest/FullControlTestEventHandlers.cpp).

## Root Cause

`GuiMenuButton` chooses the submenu’s template only when it creates the popup.
Both `CreateSubMenu` and `GuiToolstripButton::CreateToolstripSubMenu` create a
`ThemeName::Menu` window. They set its `ControlTemplate` to the caller’s factory
if supplied, otherwise to the owning button template’s `SubMenuTemplate`.
DarkSkin supplies `darkskin::ToolstripMenuTemplate` there for menu buttons and
combos. `GuiComboBoxBase` creates its popup in its constructor, so the first
click after a skin switch can open a popup created under the previous skin.
[<GacUI-repo>/Source/Controls/ToolstripPackage/GuiMenuControls.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/Controls/ToolstripPackage/GuiMenuControls.cpp#L486-L515),
[<GacUI-repo>/Source/Controls/ToolstripPackage/GuiToolstripMenu.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/Controls/ToolstripPackage/GuiToolstripMenu.cpp#L379-L402),
[<GacUI-repo>/Source/Controls/ListControlPackage/GuiComboControls.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/Controls/ListControlPackage/GuiComboControls.cpp#L58-L65).

When the button installs its new template, `GuiMenuButton::AfterControlTemplateInstalled_`
tells that template whether the submenu exists and is open, and reconnects the
input handlers. It never applies the new `SubMenuTemplate` to the existing
popup. Reopening **File** therefore shows a window that still holds the
DarkSkin factory, even though Win7Skin leaves `SubMenuTemplate` empty.
Conversely, a popup created with an empty factory keeps using the `Menu` slot
even if the new button template specifies a distinct submenu style.
`ownedSubMenu` records who deletes the window. The button has no record of
which factory it supplied and which the caller chose. An inherited factory
needs to be reassigned on each install, including when the new value is empty.
`GuiRibbonGroup` already does this for its own dropdown.
[<GacUI-repo>/Source/Controls/ToolstripPackage/GuiMenuControls.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/Controls/ToolstripPackage/GuiMenuControls.cpp#L275-L309),
[<GacUI-repo>/Source/Controls/ToolstripPackage/GuiRibbonControls.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/Controls/ToolstripPackage/GuiRibbonControls.cpp#L271-L280).

The popup itself receives the refresh even while closed. Its `GuiWindow`
constructor registers it with the application, and `GuiApplication::RefreshThemes()`
visits each live registered window. `GuiControl::RefreshThemes()` rebuilds
a control from the active theme by name when its `ControlTemplate` factory
is empty. A nonempty factory preserves the installed template object. This
keeps the copied DarkSkin frame and background in place. The editor’s
standalone context menu has an empty factory and resolves `ThemeName::Menu`
on that same refresh, before it opens.
[<GacUI-repo>/Source/Application/Controls/GuiWindowControls.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/Application/Controls/GuiWindowControls.cpp#L937-L949),
[<GacUI-repo>/Source/Application/Controls/GuiApplication.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/Application/Controls/GuiApplication.cpp#L269-L280),
[<GacUI-repo>/Source/Application/Controls/GuiBasicControls.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/Application/Controls/GuiBasicControls.cpp#L56-L143),
[editor context menu](../../Test/FullControlTest/UI/FullControlTest/DocumentEditorBase.xml#L138).

The refresh still visits children of a control whose template it preserves.
The commands under **File / Save as** are `MenuItemButton` controls with
empty factories, so their text and hover colors follow Win7Skin. List item
templates have a different lifecycle. When the combo’s `TextList` installs its
new control template, `GuiListControl::AfterControlTemplateInstalled_` tells
its arranger to reload visible rows. It recreates them as needed from the
list’s configured `ItemTemplate`, independently of the popup frame.
[File menu](../../Test/FullControlTest/UI/FullControlTest/DocumentEditorToolstrip.xml#L8-L18),
[view selector](../../Test/FullControlTest/UI/FullControlTest/ListViewTabPage.xml#L36-L49),
[<GacUI-repo>/Source/Controls/ListControlPackage/GuiListControls.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/Controls/ListControlPackage/GuiListControls.cpp#L96-L193).

## Proposal

Upstream DarkSkin can use the same empty default for ordinary menus. That
change would let the showcase remove the popup reset. If a future
skin needs a distinct inherited submenu template, GacUI could track whether
the factory came from the owner or from the caller and refresh the inherited
one when the owner template changes. Verify combo lists, nested menus and
explicitly styled popups across theme switches in both directions.
