# UbuntuSkin color package

The default follows Yaru light in Ubuntu 24.04 LTS and 26.04 LTS. Both releases use a near-white window, white content, inkstone text and the Ubuntu orange accent. The upstream widget-factory image shows the geometry of the notebook underline, check marks, scale, and progress bars. The versioned styles define the default accent and the neutral circular header buttons. [24.04 colors](https://github.com/ubuntu/yaru/blob/24.04.3/gtk/src/default/gtk-3.0/_colors.scss) · [26.04 palette](https://github.com/ubuntu/yaru/blob/26.04.5.1ubuntu/gtk/src/default/gtk-3.0/_palette.scss) · [Header buttons and focus outlines](https://github.com/ubuntu/yaru/blob/26.04.5.1ubuntu/gtk/src/default/gtk-3.0/_tweaks.scss) · [Yaru widget-factory screenshot](https://github.com/ubuntu/yaru/blob/26.04.5.1ubuntu/.github/readme_pics/factory-light.png).

## Surface and foreground colors

| Field | Default | Where it appears |
| --- | --- | --- |
| `WindowBackground` | `#FAFAFA` | Base for windows, groups, notebook headers and inactive title bars. |
| `ViewBackground` | `#FFFFFF` | Editor, list, document, notebook page and popup content. |
| `HeaderBackground` | `#FFFFFF` | Active window header bar, ribbon and tool controls. |
| `Border` | `#C7C7C7` | Borders between surfaces, content frames and entry outlines. |
| `Divider` | `#DEDEDE` | Subtle dividers between rows, columns and command groups. |
| `Ink` | `#3D3D3D` | Control text, caption glyphs, sort indicators and ordinary arrows. |
| `DocumentInk` | `#111111` | Text and caret in unformatted documents and primary calendar numerals. |
| `SecondaryInk` | `#646464` | Secondary descriptions and adjacent-month dates. |
| `DisabledInk` | `#929292` | Inactive labels, glyphs and disabled actions. |
| `Accent` | `#E95420` | Selected notebook underline, checked controls, filled scales and text selection. |
| `AccentPressed` | `#C23F12` | Pressed accent controls and dragged scrollbar handles. |
| `Focus` | `#ED835E` | Keyboard focus indicator and focused editor border. |
| `SelectedText` | `#FFFFFF` | Check marks and selected document text on orange. |
| `Clear` | `#00000000` | Areas that show the underlying surface. |
| `HoverSurface` | `#EDEDED` | Hover feedback on flat command and item surfaces. |
| `PressedSurface` | `#DCDCDC` | Pressed flat commands, open menus and active column headers. |
| `SelectedSurface` | `#FBE7DF` | Selected GacUI rows and calendar days whose label colors are shared with their neighbors. |
| `CaptionButtonSurface` | `#EAEAEA` | Resting circular window controls. |
| `Track` | `#DFDFDF` | Scale troughs and empty progress bars. |
| `KeytipBackground` | `#353535` | Background of keyboard access-key bubbles. |
| `KeytipText` | `#FFFFFF` | Text inside keyboard access-key bubbles. |

## Control states

A `ButtonColors` value carries an outline in `Border`, vertical face colors in `G1` and `G2`, the foreground in `Text` and the check/radio mark or menu-gutter color in `Bullet`. Matching gradient stops give flat fills. A checked indicator takes its fill from `Accent`, `AccentPressed` or `DisabledInk`. The scrollbar thumb uses the first face color.

| Field | Where it appears |
| --- | --- |
| `ButtonNormal` | Resting pushbutton, combo box and scale handle. |
| `ButtonHovered` | Pointer over an action surface. |
| `ButtonPressed` | Pressed action or open combo box. |
| `ButtonDisabled` | Insensitive action. |
| `CheckedNormal` | Normal unchecked check/radio and selected glyph. |
| `CheckedHovered` | Hovered check/radio frame and glyph. |
| `CheckedPressed` | Pressed check/radio frame and glyph. |
| `CheckedDisabled` | Insensitive check/radio frame, label and glyph. |
| `ItemNormal` | Resting list, tree and gallery items. |
| `ItemHovered` | Pointer over a row. |
| `ItemSelected` | Selected or pressed row. Selected rows have an orange edge. |
| `ItemDisabled` | Disabled row. |
| `TabNormal` | Resting notebook header. |
| `TabHovered` | Hovered notebook header. |
| `TabSelected` | Active notebook header and its page surface. |
| `CommandNormal` | Resting menu, toolbar, gallery arrow and ribbon commands. |
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

GacUI's graphical lists share text colors across rows. The selected row therefore uses a warm tint and an orange leading edge. The calendar uses the same tint and an orange outline around the selected day. Popup surfaces support arbitrary application content and retain a light background. Ribbon commands share the Yaru toolbar states. [List foregrounds](../../suggestions/GacUI/SelectedItemForeground.md) · [Calendar foregrounds](../../suggestions/GacUI/SelectedCalendarDayForeground.md).
