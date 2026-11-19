# Windows 10 colors

The light package opens on a white page. The dark package opens on black. Both use square controls, neutral gray button faces and the Windows blue accent for selection and value. The source for the control states and dimensions is the Windows 10 SDK 10.0.19041.0 UAP resource dictionary, `Generic/generic.xaml`. Microsoft's Windows 10 examples show the page, toolbar, field and selection colors together. [Fluent XAML Theme Editor](https://blogs.windows.com/windowsdeveloper/2018/10/10/fluent-xaml-theme-editor-preview-released/) · [Light and dark app screenshots](https://learn.microsoft.com/en-us/windows-hardware/customize/desktop/set-dark-mode)

Ribbon groups, galleries, menu bars and docked toolstrips extend the desktop command surface with the same state colors. Their headings, images and keyboard shortcuts retain the application's content.

| ColorPackage item | Light | Dark | Used for |
| --- | --- | --- | --- |
| `Page` | `#FFFFFF` | `#000000` | Window client area, tab pages, content and the background of editors. |
| `Chrome` | `#F2F2F2` | `#1F1F1F` | Menu bars, ribbon bands, popups, keytips, tooltips and scroll tracks. |
| `Divider` | `#D6D6D6` | `#414141` | Hairlines between groups, toolbar commands, list headers and menu items. |
| `Outline` | `#999999` | `#666666` | Resting input outlines, unfilled slider channel and popup edges. |
| `StrongOutline` | `#333333` | `#CCCCCC` | Resting selection-control outlines, radio dots and hovered editor frames. |
| `Text` | `#000000` | `#FFFFFF` | Enabled labels, icon strokes and the editor caret. |
| `SecondaryText` | `#5C5C5C` | `#C2C2C2` | Secondary list and calendar text, group captions and collapsed tree arrows. |
| `DisabledText` | `#7A7A7A` | `#858585` | Disabled controls, inactive window titles and disabled slider thumbs. |
| `Accent` | `#0078D7` | `#0078D7` | Selected checkboxes, radio outlines, slider value and thumb, active tab indicator, keyboard input focus and document selection. |
| `OnAccent` | `#FFFFFF` | `#FFFFFF` | Check mark and selected text over an opaque accent fill. |
| `Link` | `#0063B1` | `#60CDFF` | Default document hyperlinks over the page. |
| `Transparent` | `#00000000` | `#00000000` | Unpainted areas of unselected or inactive controls. |
| `ScrollThumb` | `#A6A6A6` | `#737373` | Mouse scrollbar thumb at rest. |
| `ScrollThumbHovered` | `#767676` | `#A6A6A6` | Mouse scrollbar thumb under the pointer. |
| `ScrollThumbPressed` | `#606060` | `#C2C2C2` | Mouse scrollbar thumb during a drag. |
| `WindowEdge` | `#707070` | `#707070` | Active custom frame outline. |
| `WindowEdgeInactive` | `#CCCCCC` | `#3A3A3A` | Inactive custom frame outline. |
| `CloseHovered` | `#E81123` | `#E81123` | Close caption button while hovered. |
| `ClosePressed` | `#C50F1F` | `#A00B18` | Close caption button while pressed. |

Each state below has a `Border` for its edge, a `Fill` for the interior and a `Text` color for its foreground. List content can supply its own primary and secondary foregrounds.

| State | Used for |
| --- | --- |
| `ButtonNormal` | Neutral square pushbutton at rest. |
| `ButtonHovered` | Pointer-over pushbutton with a two-pixel edge. |
| `ButtonPressed` | Pressed pushbutton face. |
| `ButtonDisabled` | Disabled pushbutton face and lettering. |
| `InputNormal` | Resting combo box or text input. |
| `InputHovered` | Input or combo box with the pointer inside. |
| `InputFocused` | Focused input or open combo box. |
| `InputDisabled` | Disabled input or combo box. |
| `CommandNormal` | Resting menu, ribbon, toolbar, tab or scroll arrow. |
| `CommandHovered` | Hovered command on a chrome surface. |
| `CommandPressed` | Pressed command or open submenu. |
| `CommandDisabled` | Disabled command or scrollbar arrow. |
| `ItemNormal` | Resting calendar date or list row. |
| `ItemHovered` | Hovered list row, date or column heading. |
| `ItemSelected` | Selected list row, date or toggled command. |
| `ItemSelectedHovered` | Selected list row or menu command under the pointer. |
| `ItemDisabled` | Disabled list row or calendar date. |
