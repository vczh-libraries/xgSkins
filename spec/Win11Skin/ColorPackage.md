# Windows 11 color package

`CreateDefaultColorPackage()` supplies the light palette. `CreateDarkColorPackage()` supplies the dark palette. Both use the stock Windows blue accent. The canvas, content layer and transient flyout have distinct surface values. The hosted renderer paints solid equivalents for Mica and acrylic.

The dimensions and artwork follow Microsoft’s [Windows geometry examples](https://learn.microsoft.com/en-us/windows/apps/design/signature-experiences/geometry). The foreground, surface and stroke hierarchy follows the [WinUI theme resources](https://github.com/microsoft/microsoft-ui-xaml/blob/main/controls/dev/CommonStyles/Common_themeresources_any.xaml).

## Shared colors

| Field | Light | Dark | Use |
| --- | --- | --- | --- |
| `Canvas` | `#F3F3F3` | `#202020` | Window, title bar, ribbon and toolbar base. |
| `Layer` | `#FFFFFF` | `#2B2B2B` | Content pane, page or document surface. |
| `Flyout` | `#F9F9F9` | `#2C2C2C` | Menu, tooltip, keytip and ribbon popup surface. |
| `Stroke` | `#E1E1E1` | `#454545` | Control outlines, dividers, groups and unobtrusive window outlines. |
| `StrongStroke` | `#8B8B8B` | `#9F9F9F` | Input underline, unchecked option outlines and unfilled slider rail. |
| `Foreground` | `#1B1B1B` | `#FFFFFF` | Primary text, icons and the caret. |
| `Secondary` | `#606060` | `#CECECE` | Secondary text, arrows and inactive window captions. |
| `Disabled` | `#9B9B9B` | `#808080` | Disabled text and glyphs. |
| `Accent` | `#005FB8` | `#60CDFF` | Selection indicators, checked options, progress fill and input focus underline. |
| `OnAccent` | `#FFFFFF` | `#000000` | Check mark, radio center and selected document text. |
| `CloseHover` | `#C42B1C` | `#C42B1C` | Close caption button on pointer over. |
| `ClosePressed` | `#AA2619` | `#AA2619` | Close caption button while pressed. |
| `CloseGlyph` | `#FFFFFF` | `#FFFFFF` | Foreground of the highlighted close caption button. |
| `Transparent` | `#00000000` | `#00000000` | Unpainted surfaces and hidden glyphs. |

## Control states

Each `ButtonColors` value has an outline (`Border`), interior (`Face`), foreground (`Text`) and optional check or radio mark (`Bullet`). Translucent backplates allow the underlying canvas, page or flyout to show through. Each state is independently customizable.

| Field | Use |
| --- | --- |
| `ButtonNormal` | Pushbutton, combo and slider thumb at rest. |
| `ButtonHovered` | Hovered pushbutton, combo or slider thumb. |
| `ButtonPressed` | Pressed pushbutton, open combo or pressed slider thumb. |
| `ButtonDisabled` | Disabled pushbutton, combo or slider thumb. |
| `MarkNormal` | Unchecked checkbox and radio at rest. |
| `MarkHovered` | Hovered unchecked checkbox or radio. |
| `MarkPressed` | Pressed unchecked checkbox or radio. |
| `MarkDisabled` | Disabled unchecked checkbox or radio. |
| `CheckedNormal` | Selected checkbox or radio. |
| `CheckedHovered` | Hovered selected checkbox or radio. |
| `CheckedPressed` | Pressed selected checkbox or radio. |
| `CheckedDisabled` | Disabled selected checkbox or radio. |
| `SubtleNormal` | Resting menu, toolbar and ribbon commands, item backplates and tab headers. |
| `SubtleHovered` | Hovered command, menu row, tab, list row and calendar day. |
| `SubtlePressed` | Pressed command or open menu header. |
| `SubtleSelected` | Selected list row, menu choice, calendar day or toggled command. |
| `SubtleDisabled` | Disabled menu, list, calendar and command chrome. |
| `ThumbNormal` | Resting scrollbar thumb. |
| `ThumbHovered` | Hovered scrollbar thumb. |
| `ThumbPressed` | Dragged scrollbar thumb. |

## Editor states

Each `EditorColors` value has a `Border` and `Background`. The focus line uses `Accent`.

| Field | Use |
| --- | --- |
| `EditorNormal` | Unfocused input or list container. |
| `EditorHovered` | Hovered input or list container. |
| `EditorFocused` | Focused input or list container. |
| `EditorDisabled` | Disabled input or list container. |
