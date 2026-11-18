# Ordinary submenus retain the theme that created them

Switching from DarkSkin to Win7Skin in FullControlTest left the File menu with
DarkSkin’s `#1B1B1C` background and `#333337` border. Its rows already had
Win7Skin’s black text, transparent resting face and hover colors. The list-view
combo reproduced the same dark frame. The first level of the editor context
menu picked up the new theme.

Both menu creation paths construct a popup with `ThemeName::Menu` and copy
the owner template’s `SubMenuTemplate` into the popup’s explicit
`ControlTemplate`. Combo boxes create their popup during construction. A
theme refresh retains explicit templates, including the one copied from the
original owner. See [<GacUI-repo>/Source/Controls/ToolstripPackage/GuiMenuControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ToolstripPackage/GuiMenuControls.cpp),
[<GacUI-repo>/Source/Controls/ToolstripPackage/GuiToolstripMenu.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ToolstripPackage/GuiToolstripMenu.cpp),
[<GacUI-repo>/Source/Controls/ListControlPackage/GuiComboControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiComboControls.cpp)
and [<GacUI-repo>/Source/Application/Controls/GuiBasicControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/Controls/GuiBasicControls.cpp).

For ordinary popups, register the skin’s menu template in the theme’s `Menu`
slot and leave the button’s `SubMenuTemplate` empty. An explicit template
passed by the application still takes precedence. FullControlTest also clears
the redundant stock submenu factory when it creates DarkSkin’s button and
combo templates. Its startup theme and the DarkSkin selector use the same
registration. See [FullControlTestEventHandlers.cpp](../Test/FullControlTest/FullControlTestEventHandlers.cpp).

Upstream DarkSkin can use the same empty default for ordinary menus. That
change would let the showcase remove its DarkSkin factory adapter. If a future
skin needs a distinct inherited submenu template, GacUI could track whether
the factory came from the owner or from the caller and refresh the inherited
one when the owner template changes. Verify combo lists, nested menus and
explicitly styled popups across theme switches in both directions.
