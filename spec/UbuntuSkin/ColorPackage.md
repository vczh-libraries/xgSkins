# UbuntuSkin color package

UbuntuSkin follows the default **Yaru Standard** appearance in Ubuntu 20.04 LTS (Focal Fossa). The Files window in the reference pairs a charcoal header and an orange close button with a porcelain sidebar and white file area. The open system menu shows the corresponding light popup, gray hover band and aubergine scale. The desktop wallpaper, panel and dock belong to the shell. [Canonical’s theme announcement](https://ubuntu.com/blog/new-ubuntu-theme-in-development-for-20-04) · [Yaru 20.04.7 base colors](https://github.com/ubuntu/yaru/blob/20.04.7/gtk/src/default/gtk-3.20/_colors.scss) · [Ubuntu palette](https://github.com/ubuntu/yaru/blob/20.04.7/gtk/src/default/gtk-3.20/_ubuntu-colors.scss) · [Mixed header bar](https://github.com/ubuntu/yaru/blob/20.04.7/gtk/src/default/gtk-3.20/_headerbar.scss) · [Window controls](https://github.com/ubuntu/yaru/blob/20.04.7/gtk/src/default/gtk-3.20/_tweaks.scss) · [Upstream widget factory](https://github.com/ubuntu/yaru/blob/20.04.7/docs/widget-factory1.png).

## Surface and foreground colors

| Field | Default | Where it appears |
| --- | --- | --- |
| `WindowBackground` | `#F7F7F7` | Porcelain window, sidebar, ribbon group and standalone toolbar surfaces. |
| `ViewBackground` | `#FFFFFF` | White editor, list, document, notebook page and tooltip content. |
| `HeaderBackground` | `#323030` | Active custom window header, menubar and ribbon tab band. |
| `InactiveHeaderBackground` | `#3F3D3D` | Backdrop window header. |
| `HeaderInk` | `#F7F7F7` | Window title and active minimize, maximize and restore glyphs. |
| `InactiveHeaderInk` | `#BBBABA` | Inactive caption and insensitive dark-header text. |
| `PopupBackground` | `#FAFAFA` | Menu, embedded menu toolbar and expanded ribbon group. |
| `ControlAccent` | `#924D8B` | Aubergine check/radio fills, menu check marks, filled scales and progress. |
| `ControlAccentPressed` | `#743D6F` | Pressed selected checkbox or radio. |
| `Border` | `#C6C6C6` | Borders between surfaces, content frames and popup outlines. |
| `Divider` | `#D8D8D8` | Dividers between rows, columns and groups of commands. |
| `Ink` | `#3D3D3D` | Control text, sort indicators, ordinary arrows and secondary list labels. |
| `DocumentInk` | `#181818` | Unformatted document text, caret and primary calendar numerals. |
| `SecondaryInk` | `#646464` | Secondary descriptions and adjacent-month dates. |
| `DisabledInk` | `#929292` | Insensitive labels, controls and glyphs on light surfaces. |
| `Accent` | `#E95420` | Orange close disc, active notebook underline, document selection and selected-date edge. |
| `AccentPressed` | `#BF4214` | Pressed close disc. |
| `Focus` | `#EF895F` | Keyboard focus outlines and close-button hover. |
| `SelectedText` | `#FFFFFF` | Close cross and selected document text. |
| `Clear` | `#00000000` | Resting caption actions, unpainted surfaces and transparent marks. |
| `HoverSurface` | `#E8E8E8` | Hovered column headers, column filter and date cells. |
| `PressedSurface` | `#D6D6D6` | Pressed column headers. |
| `SelectedSurface` | `#E95420` | Selected date and highlighted page underline. |
| `CaptionButtonSurface` | `#535150` | Hover circle behind minimize, maximize and restore. |
| `Track` | `#C7C7C7` | Empty portion of a scale or progress bar. |
| `KeytipBackground` | `#353535` | Background of keyboard access-key bubbles. |
| `KeytipText` | `#FFFFFF` | Text in keyboard access-key bubbles. |

## Control states

A `ButtonColors` value carries an outline in `Border`, vertical face colors in `G1` and `G2`, the foreground in `Text` and the indicator mark in `Bullet`. Matching gradient stops give flat fills. A checked indicator takes its fill from `ControlAccent`, `ControlAccentPressed` or `DisabledInk`. The scrollbar thumb uses the first face color.

| Field | Where it appears |
| --- | --- |
| `ButtonNormal` | Resting pushbutton, standalone toolbar action, combo box and scale handle. |
| `ButtonHovered` | Pointer over an action surface. |
| `ButtonPressed` | Pressed action or open combo box. |
| `ButtonDisabled` | Insensitive action. |
| `CheckedNormal` | Normal unchecked check/radio and selected glyph. |
| `CheckedHovered` | Hovered check/radio frame and glyph. |
| `CheckedPressed` | Pressed check/radio frame and glyph. |
| `CheckedDisabled` | Insensitive check/radio frame, label and glyph. |
| `ItemNormal` | Resting list, tree and gallery items. |
| `ItemHovered` | Pointer over a row. |
| `ItemSelected` | Full-width solid orange selected or pressed row. |
| `ItemDisabled` | Disabled row. |
| `TabNormal` | Resting notebook header. |
| `TabHovered` | Hovered notebook header. |
| `TabSelected` | Active notebook header and its page surface. |
| `HeaderActionNormal` | Compact charcoal menubar actions, ribbon tabs, active window border and menubar separator. |
| `HeaderActionHovered` | Hovered header actions and ribbon tabs. |
| `HeaderActionPressed` | Open header menu, pressed caption control and selected ribbon tab. |
| `HeaderActionDisabled` | Inactive header actions and disabled ribbon tabs. |
| `CommandNormal` | Resting popup menu, gallery arrow and ribbon commands. |
| `CommandHovered` | Hovered command. |
| `CommandPressed` | Pressed command and open dropdown. |
| `CommandSelected` | Latched command. |
| `CommandDisabled` | Disabled command. |
| `ScrollHandleNormal` | Resting scrollbar thumb. |
| `ScrollHandleActive` | Hovered scrollbar thumb. |
| `ScrollHandlePressed` | Dragged scrollbar thumb. |
| `ScrollHandleDisabled` | Inactive scrollbar thumb. |

Each `EditorColors` value contains a `Border` and a `Background`. Text entries, document editors, lists and trees share these states.

| Field | Where it appears |
| --- | --- |
| `EditorNormal` | Resting entry or view. |
| `EditorHovered` | Hovered entry or view. |
| `EditorFocused` | Focused entry or view. |
| `EditorDisabled` | Insensitive entry or view. |

Built-in graphical lists and calendars share foregrounds across their items. The skin uses an edge-to-edge orange row with near-black primary labels to preserve contrast in all six list views and the data grid. Editor selection uses white on orange. The calendar keeps each date’s month-dependent ink on a compact orange selected tile. Light menu rows highlight in gray and use an aubergine tick for a checked command. [List foregrounds](../../suggestions/GacUI/SelectedItemForeground.md) · [Calendar foregrounds](../../suggestions/GacUI/SelectedCalendarDayForeground.md).

Yaru’s inverted header bar supplies the menubar and ribbon tab treatment. The standalone toolbar and ribbon command groups use traditional light GTK surfaces so the application’s supplied bitmap icons remain legible. Ribbon header extension areas keep a light backing for application-supplied labels and controls.
