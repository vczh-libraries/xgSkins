# Windows 10 colors

The light skin uses the Windows 10 desktop control colors. Reference samples were drawn from the Windows 10 22H2 visual style on build 19045 using the BUTTON, EDIT, COMBOBOX, TAB, MENU and TOOLBAR classes. The dark skin takes its pushbutton colors from the same system's DarkMode_Explorer button theme and adapts the surrounding surfaces and selection marks for dark backgrounds. [Win32 visual style parts and states](https://learn.microsoft.com/en-us/windows/win32/controls/parts-and-states) · [DrawThemeBackground](https://learn.microsoft.com/en-us/windows/win32/api/uxtheme/nf-uxtheme-drawthemebackground)

Ribbon groups, galleries, menu bars and docked toolstrips extend the desktop command surface with the same state colors. Their headings, images and keyboard shortcuts retain the application's content.

| ColorPackage item | Light | Dark | Used for |
| --- | --- | --- | --- |
| `Page` | `#FFFFFF` | `#202020` | Selected tab pages, content, editors and the caption background. |
| `Chrome` | `#F2F2F2` | `#2B2B2B` | Menu bars, ribbon bands, popups, keytips, tooltips and scroll tracks. |
| `Divider` | `#D9D9D9` | `#484848` | Hairlines between groups, toolbar commands, list headers and menu items. |
| `Outline` | `#7A7A7A` | `#797979` | Resting input outlines, unfilled slider channel and popup edges. |
| `StrongOutline` | `#333333` | `#CCCCCC` | Resting checkbox outlines, ticks, radio rings and dots. |
| `Text` | `#000000` | `#FFFFFF` | Enabled labels, icon strokes and the editor caret. |
| `SecondaryText` | `#5C5C5C` | `#C2C2C2` | Secondary list and calendar text, group captions and collapsed tree arrows. |
| `DisabledText` | `#7A7A7A` | `#858585` | Disabled controls, inactive window titles and disabled slider thumbs. |
| `Accent` | `#0078D7` | `#0078D7` | Hovered checkbox and radio marks, slider value and thumb, contextual ribbon tabs, keyboard focus and document selection. |
| `OnAccent` | `#FFFFFF` | `#FFFFFF` | Selected document text and the close glyph over its red button. |
| `Link` | `#0063B1` | `#60CDFF` | Default document hyperlinks over the page. |
| `Transparent` | `#00000000` | `#00000000` | Unpainted areas of unselected or inactive controls. |
| `ScrollThumb` | `#A6A6A6` | `#737373` | Mouse scrollbar thumb at rest. |
| `ScrollThumbHovered` | `#767676` | `#A6A6A6` | Mouse scrollbar thumb under the pointer. |
| `ScrollThumbPressed` | `#606060` | `#C2C2C2` | Mouse scrollbar thumb during a drag. |
| `WindowEdge` | `#707070` | `#707070` | Active custom frame outline. |
| `WindowEdgeInactive` | `#CCCCCC` | `#3A3A3A` | Inactive custom frame outline. |
| `CloseHovered` | `#E81123` | `#E81123` | Close caption button while hovered. |
| `ClosePressed` | `#C50F1F` | `#A00B18` | Close caption button while pressed. |
| `WindowSurface` | `#F0F0F0` | `#191919` | Window client background and band behind tab headers. |
| `MenuHighlight` | `#99D1FF` | `#414141` | Hovered popup-menu item or open submenu. |

Each state below has a `Border` for its edge, a `Fill` for the interior and a `Text` color for its foreground. List content can supply its own primary and secondary foregrounds.

| State | Used for |
| --- | --- |
| `ButtonNormal` | Resting pushbutton and read-only combo. The light face is `#E1E1E1` with an `#ADADAD` edge. Dark uses `#333333` and `#9B9B9B`. |
| `ButtonHovered` | Hovered pushbutton and read-only combo. The light face is `#E5F1FB` with an `#0078D7` edge. Dark uses `#454545` and `#9B9B9B`. |
| `ButtonPressed` | Pressed pushbutton, selection mark or open read-only combo. The light face is `#CCE4F7` with an `#005499` edge. Dark uses `#666666` and `#9B9B9B`. |
| `ButtonDisabled` | Disabled pushbutton or read-only combo. |
| `InputNormal` | Resting text input. |
| `InputHovered` | Text input with the pointer inside. |
| `InputFocused` | Focused text input. |
| `InputDisabled` | Disabled text input, checkbox or radio button. |
| `CommandNormal` | Resting menu, ribbon, toolbar or scroll arrow. |
| `CommandHovered` | Hovered command on a chrome surface. |
| `CommandPressed` | Pressed command or open submenu. |
| `CommandDisabled` | Disabled command or scrollbar arrow. |
| `ItemNormal` | Resting calendar date or list row. |
| `ItemHovered` | Hovered list row, date or column heading. |
| `ItemSelected` | Selected list row, date or toggled command. |
| `ItemSelectedHovered` | Selected list row under the pointer. |
| `ItemDisabled` | Disabled list row or calendar date. |
| `TabNormal` | Resting property-sheet or ribbon tab. The selected face uses the page color and joins the pane below. |
| `TabHovered` | Hovered tab with a pale blue face in light mode and a lighter gray fill in dark mode. |
