# UbuntuSkin color package

UbuntuSkin follows the light appearance in the supplied Ubuntu 26.04 LTS screenshots. Files and Settings supply the control states. LibreOffice Writer supplies the separate title bar, menubar, toolbar and tab accents. GacUI supplies the fonts and control metrics. The skin uses rectangular faces and popups, a compact combo arrow and horizontal or vertical tab headers. Caption discs, radio indicators and scale handles retain their circular silhouettes. The skin draws its glyphs with `<Polygon/>`. [Reference notes](../../screenshots/README.md), [Ubuntu 26.04 LTS release notes](https://documentation.ubuntu.com/release-notes/26.04/summary-for-lts-users/).

## Surfaces and foregrounds

| Field | Default | Use |
| --- | --- | --- |
| `WindowBackground` | `#FAFAFA` | Window body, toolbars, ribbon groups and scroll troughs. |
| `SidebarBackground` | `#FFFFFF` | Tree view, matching the default list surface. |
| `ViewBackground` | `#FFFFFF` | Lists, multiline text boxes, rich documents, notebook pages, resting column headers and scale handles. |
| `HeaderBackground` | `#EBEBEB` | Active title bar and frame. |
| `InactiveHeaderBackground` | `#F0F0F0` | Inactive title bar and frame. |
| `FrameBorder` | `#BDBDBD` | Active window perimeter and the hairline below the title. |
| `HeaderInk` | `#3D3D3D` | Active title and caption glyphs. |
| `InactiveHeaderInk` | `#959595` | Inactive title and unavailable caption glyphs. |
| `CaptionButtonSurface`, `CaptionButtonHovered`, `CaptionButtonPressed` | `#DADADA`, `#CECECE`, `#C1C1C1` | Resting, hovered and pressed caption discs for all three window actions. |
| `InactiveCaptionButtonSurface` | `#E7E7E7` | Caption discs in a backdrop window or behind an unavailable action. |
| `PopupBackground` | `#FAFAFA` | Popup menus, their embedded toolbars and expanded ribbon groups. |
| `Border`, `Divider` | `#C7C7C7`, `#E1E1E1` | View frames and popup borders, then hairlines between commands, columns and pages. |
| `Ink`, `DocumentInk` | `#3D3D3D`, `#3D3D3D` | Control labels and arrows, then unformatted document text and primary calendar numerals. |
| `SecondaryInk` | `#6F6F6F` | Secondary list descriptions, sorting chevrons, shortcuts, group captions and adjacent-month numerals. |
| `DisabledInk` | `#9B9B9B` | Disabled text, glyphs and indicator fills. |
| `ControlAccent`, `ControlAccentPressed` | `#D34615`, `#AD3911` | Checked indicators, scale and progress fills, and the rim of an active or pressed scale handle. |
| `Accent`, `AccentPressed` | `#E95420`, `#BF4214` | Selected calendar edge and pressed tab underline. The default selected tab and open menubar item also use the LibreOffice orange. |
| `Focus` | `#DB977F` | Keyboard focus outlines and the rim of a resting scale handle. |
| `SelectionBackground`, `SelectedText` | `#E4BAAB`, `#6B4132` | Peach document selection with dark lettering. |
| `HoverSurface`, `PressedSurface` | `#E2E2E2`, `#C5C5C5` | Hovered and pressed column headers, filter buttons and calendar cells. Inline and expanded ribbon galleries also use `HoverSurface` for item hover. |
| `SelectedSurface` | `#E4E4E4` | Selected calendar day behind the current- or adjacent-month text. |
| `Track` | `#E2E2E2` | Unfilled scale and progress track. |
| `KeytipBackground`, `KeytipText` | `#323232`, `#FFFFFF` | Tooltips and keyboard access keys. A default label inside a tooltip uses the light foreground. |
| `Clear` | Transparent | Unpainted surfaces and marks. |

The window title and its three right-hand actions sit above a separate command area. All three actions have a gray disc and dark glyph in an active window. [Writer frame and menu](../../screenshots/LibreOfficeReference/MenuBarAndDropdownMenu.png).

## Control states

`ButtonColors` contains the border, the two face colors `G1` and `G2`, the text and the indicator color `Bullet`. Both face colors match in the default package. An `EditorColors` value contains a border and a background.

| Fields | Use |
| --- | --- |
| `ButtonNormal`, `ButtonHovered`, `ButtonPressed`, `ButtonDisabled` | Pushbutton faces progress through `#E7E7E7`, `#DEDEDE` and `#C1C1C1`. Disabled buttons use `#F5F5F5`. |
| `ComboNormal` | White combo face and gray outline. Hover, press and open use the corresponding command colors. The dropdown list meets the one-pixel popup frame on all four sides. |
| `CheckedNormal`, `CheckedHovered`, `CheckedPressed`, `CheckedDisabled` | Check and radio frames, labels and marks. Selection fills the indicator with the control accent and reveals its white tick or dot. |
| `ItemNormal`, `ItemHovered`, `ItemPressed`, `ItemSelected`, `ItemDisabled` | Hovered, pressed and selected rows use borderless fills. List and tree hover uses `#F7F7F7`, gallery hover uses `HoverSurface`, a held press uses `#F0F0F0` and selection uses `#E4E4E4`. |
| `TabNormal`, `TabHovered`, `TabSelected` | Notebook and ribbon tab headers have a one-pixel gray bottom rule at rest. Hover thickens it to three pixels. Selection draws the three-pixel orange `TabSelected.Bullet` rule. Keyboard focus draws `TabSelected.Border` along the top and sides, ending at the orange rule. |
| `HeaderActionNormal`, `HeaderActionHovered`, `HeaderActionPressed`, `HeaderActionDisabled` | Menubar actions. An open menu has a gray face and orange bottom edge. Popup rows use the same gray hover face. |
| `CommandNormal`, `CommandHovered`, `CommandPressed`, `CommandOpen`, `CommandSelected`, `CommandDisabled` | Toolbar and ribbon buttons and gallery arrows. Resting actions blend into the bar. Hover adds a fine border and `#F5F5F5` face. Pressed or latched actions use `#D6D6D6`. Open dropdowns have a light face and distinct border. A checked menu command shows the selected indicator color or a backing behind its image. |
| `ScrollHandleNormal`, `ScrollHandleActive`, `ScrollHandlePressed`, `ScrollHandleDisabled` | Arrowless scrollbar thumbs darken from `#898989` to `#727272` on hover and `#595959` during a drag. |
| `EditorNormal`, `EditorHovered`, `EditorFocused`, `EditorBackdrop`, `EditorDisabled` | Single-line fields have a gray face and a peach focus outline. An inactive window fades the single-line field to `#F5F5F5`. Multiline boxes, rich documents and lists share white content surfaces and the editor hover and focus edges. |

The row, text-selection and button colors come from separate interactions in Files. The square checkbox uses the Settings radio colors. The white scale handle, orange fill and light remaining track follow the volume control. [List selection](../../screenshots/UbuntuReference/TrashBin_FirstItemHighlighted_SecondItemSelected.png), [Row press](../../screenshots/UbuntuReference/TrashBin_FirstItemPressed_SecondItemSelected.png), [Text selection](../../screenshots/UbuntuReference/TrashBin_TextBox_FocusedAndPartialSelected.png), [Radio buttons](../../screenshots/UbuntuReference/RadioButton_SecondPressed.png), [Volume scale](../../screenshots/UbuntuReference/LabelAndProgressBar.png).

Ribbon commands use the Writer toolbar states at both button sizes. Writer's selected-tab strip appears along the bottom of a horizontal Tab header and the right edge of a VTab header. The focus outline meets the strip on either end. [Toolbar hover and tooltip](../../screenshots/LibreOfficeReference/ToolBarHighlighted_Tooltip.png), [Pressed toolbar button](../../screenshots/LibreOfficeReference/ToolBarPressed.png), [Open split button](../../screenshots/LibreOfficeReference/ToolBar_Split_Selected.png), [Tab reference](../../screenshots/LibreOfficeReference/VerticalTag_SecondSelected_ThirdHighlighted.png).
