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

Both menu creation paths construct a popup with `ThemeName::Menu` and copy
the owner template’s `SubMenuTemplate` into the popup’s explicit
`ControlTemplate`. Combo boxes create their popup during construction. A
theme refresh retains explicit templates, including the one copied from the
original owner. See
[<GacUI-repo>/Source/Controls/ToolstripPackage/GuiMenuControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ToolstripPackage/GuiMenuControls.cpp),
[<GacUI-repo>/Source/Controls/ToolstripPackage/GuiToolstripMenu.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ToolstripPackage/GuiToolstripMenu.cpp),
[<GacUI-repo>/Source/Controls/ListControlPackage/GuiComboControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiComboControls.cpp)
and
[<GacUI-repo>/Source/Application/Controls/GuiBasicControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/Controls/GuiBasicControls.cpp).

## Proposal

Upstream DarkSkin can use the same empty default for ordinary menus. That
change would let the showcase remove the popup reset. If a future
skin needs a distinct inherited submenu template, GacUI could track whether
the factory came from the owner or from the caller and refresh the inherited
one when the owner template changes. Verify combo lists, nested menus and
explicitly styled popups across theme switches in both directions.
