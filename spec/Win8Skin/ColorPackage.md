# Win8Skin default color package

Win8Skin provides one default color theme: the light Windows 8 desktop
appearance. Gray window surfaces, white content, dark text, blue state feedback,
gray scrollbars and solid green progress should remain recognizable. Most
surfaces are flat and square; pushbuttons and tab headers retain their subtle
vertical gradients. Disabled, focused, selected and hovered states must remain
distinguishable. Tooltips and keytips retain pale-yellow surfaces.

Every skin color belongs to `win8skin::ColorPackage`, including colors
used for helper artwork. The package is declared in
[Win8Skin.xml](../../Source/Win8Skin/UI/Win8Skin.xml). The following items define
its required uses; technical provenance and integration are in
[doc/Win8Skin.md](../../doc/Win8Skin.md).

`ButtonColors` uses `Border` for the outline, `G1`/`G2` for a single
vertical gradient, `Text` for text/arrows, and `Bullet` for check/radio marks.
Flat faces give `G1` and `G2` the same color. Menu-item packages use `Bullet`
for their one-pixel icon-gutter separator and `Text` for the check/submenu glyphs.
The unchecked mark blends into the face. `HideBackground` leaves the parent
visible in resting or disabled rows, menu headers and ribbon commands. Scrollbar arrows and thumbs have their own state
packages, separate from pushbuttons and tracker thumbs.

`EditorColors` has `Border` and `Background`, shared by editable text/document
controls and list/tree outer borders. It does not change item selection colors.

In the Windows 8 property sheet, the selected header shares its white face with the page. Its side edges continue to the pane and its bottom is open. In Explorer, the inactive ribbon headers sit on white and the active Home header shares the light gray ribbon face. [Microsoft Press, Introducing Windows 8, figure 3-3](https://download.microsoft.com/download/b/1/e/b1e7f4c9-304d-456c-bd96-a2287fa7871d/microsoft_press_ebook_introducing_windows_8_pdf.pdf#page=39), [Microsoft Windows 8 brochure, page 18](https://download.microsoft.com/download/6/F/5/6F512314-780B-42D7-9D56-BA501352B78A/W8_brochure_download.pdf#page=18)

The Windows 8 Explorer capture shows a selected file with a `#D1E8FF` interior and a thin, stronger blue edge. It corroborates the skin’s legacy selection palette. The Details pane toggle in the ribbon has a `#C9E0F7` face, with some neighboring pixels sampled at `#C8DFF6` in the rescaled illustration. [Selected file in Windows 8](https://1214119.sites.myregisteredsite.com/Lessons/win/filesandfolders/screentip-file-properties-penguins-win8.png), [selected Details pane command](https://1214119.sites.myregisteredsite.com/Lessons/win/filesandfolders/ribbon-fileexplorer-view-detailspane-win8.png)

## State packages
| ColorPackage item | Required use |
| --- | --- |
| `ButtonNormal` | Normal pushbuttons, combo boxes and tracker thumbs. |
| `ButtonHovered` | Hovered pushbuttons, combo boxes and tracker thumbs. |
| `ButtonPressed` | Pressed pushbuttons, open combo boxes and pressed tracker thumbs. |
| `ButtonDisabled` | Disabled pushbuttons, combo boxes and tracker thumbs. |
| `ItemNormal` | Leaves the backing visible on resting list, tree, gallery and calendar items. |
| `ItemHovered` | Pale-blue hovered list/tree/gallery item and calendar-date chrome. |
| `ItemSelected` | Blue selected or pressed list/tree/gallery item and calendar-date chrome. |
| `ItemDisabled` | Leaves the backing visible on disabled list, tree, gallery and calendar items and supplies the disabled foreground. |
| `CheckedNormal` | Normal check/radio frame, flat face, text and selected mark. |
| `CheckedHovered` | Hovered check/radio frame, flat face, text and selected mark. |
| `CheckedPressed` | Pressed check/radio frame, flat face, text and selected mark. |
| `CheckedDisabled` | Disabled check/radio frame, flat face, text and selected mark. |
| `ToolstripButtonNormal` | Normal toolbar command surface. |
| `ToolstripButtonActive` | Hovered toolbar command surface. |
| `ToolstripButtonPressed` | Pressed toolbar command or open dropdown surface. |
| `ToolstripButtonSelected` | Selected toolbar command surface. |
| `ToolstripButtonDisabled` | Disabled toolbar command surface and foreground. |
| `ScrollHandleNormal` | Flat normal gray scrollbar thumb. |
| `ScrollHandleActive` | Flat darker hovered scrollbar thumb. |
| `ScrollHandlePressed` | Flat darker pressed scrollbar thumb. |
| `ScrollHandleDisabled` | Disabled thumb palette. The scrollbar hides the thumb while disabled. |
| `ScrollArrowNormal` | Normal scrollbar-arrow and gallery-scroll button surface with gray arrow. |
| `ScrollArrowActive` | Hovered scrollbar-arrow and gallery-scroll button surface with black arrow. |
| `ScrollArrowPressed` | Pressed scrollbar-arrow and gallery-scroll button surface with white arrow. |
| `ScrollArrowDisabled` | Disabled scrollbar-arrow and gallery-scroll button surface with muted arrow. |
| `MenuBarButtonNormal` | Normal menu-bar command state. |
| `MenuBarButtonActive` | Hovered menu-bar command state. |
| `MenuBarButtonPressed` | Pressed menu-bar command or open submenu state. |
| `MenuBarButtonDisabled` | Disabled menu-bar command state. |
| `MenuItemButtonNormal` | Normal menu row and icon-gutter separator. |
| `MenuItemButtonNormalActive` | Hovered or open normal menu row. |
| `MenuItemButtonSelected` | Selected menu row. |
| `MenuItemButtonSelectedActive` | Hovered selected menu row. |
| `MenuItemButtonDisabled` | Disabled menu row and foreground. |
| `MenuItemButtonDisabledActive` | Hovered disabled menu row. |
| `TabNormal` | Normal unselected tab header. |
| `TabHovered` | Hovered or pressed unselected tab header. |
| `TabSelected` | Selected tab header joined visually to its white page. |
| `RibbonButtonNormal` | Leaves the flat ribbon surface visible behind a resting command. |
| `RibbonButtonActive` | Blue hovered ribbon command chrome. |
| `RibbonButtonPressed` | Blue pressed ribbon command or open dropdown chrome. |
| `RibbonButtonSelected` | Selected ribbon command with a `#C9E0F7` face and a `#60A1E2` edge. |
| `RibbonButtonDisabled` | Leaves the ribbon surface visible and supplies the disabled foreground. |

## Editor packages
| ColorPackage item | Required use |
| --- | --- |
| `EditorNormal` | Gray border and white interior when neither focused nor hovered. |
| `EditorHovered` | Pale-blue border and white interior on hover. |
| `EditorFocused` | Strong blue border and white interior while focused. |
| `EditorDisabled` | Muted border and gray interior while disabled. |

## Shared surfaces and foregrounds
| ColorPackage item | Required use |
| --- | --- |
| `GeneralBackground` | Gray window client areas, generic scroll views, tracker surrounds and calendar background. |
| `GeneralBorder` | General control outlines and generic scroll-view borders. |
| `GeneralAccent` | Document selection background. |
| `ContentBackground` | White content surfaces and selected-page interiors. |
| `TextNormal` | Ordinary enabled labels, control/list text, active caption text and editor caret. |
| `TextBright` | Primary document/calendar foreground, document-label caret and active shared arrows. |
| `TextSecondary` | Secondary calendar text, secondary glyphs and inactive detail text. |
| `TextDisabled` | Disabled labels, controls and glyphs. |
| `GroupText` | Enabled group-box caption. |
| `GroupBorder` | Single rectangular group-box border. |
| `SelectionText` | Document selection foreground paired with `GeneralAccent`. |
| `ButtonBackgroundHovered` | Unfocused ribbon-gallery outline. |
| `ControlAccentHovered` | Focused ribbon-gallery outline. |

## Lists, headers, trees and tabs
| ColorPackage item | Required use |
| --- | --- |
| `HeaderBackground` | Normal list-view header background and lower separator/pressed-gradient endpoint. |
| `HeaderBackgroundPressed` | Pressed list-view header background. |
| `HeaderSeparatorTop` | Upper endpoint of the normal header's vertical separator. |
| `HeaderBorderPressed` | Pressed header and active header-dropdown border. |
| `HeaderBorderHovered` | Hovered header border. |
| `HeaderGradientPressedTop` | Upper endpoint of the pressed header gradient. |
| `HeaderGradientHoveredTop` | Upper endpoint of the hovered header gradient. |
| `HeaderGradientHoveredBottom` | Lower endpoint of the hovered header gradient. |
| `HeaderText` | Header text, sort arrows and dropdown arrow. |
| `HeaderDropDownTop` | Upper endpoint of the hovered header-dropdown gradient. |
| `HeaderDropDownBottom` | Lower endpoint of the hovered header-dropdown gradient. |
| `TreeArrowBorder` | Outline of a collapsed tree expander. |
| `TreeArrowBackground` | Interior of a collapsed tree expander. |
| `TreeArrowBorderExpanded` | Outline of an expanded tree expander. |
| `TreeArrowBackgroundExpanded` | Interior of an expanded tree expander. |
| `TreeArrowBorderHovered` | Hovered tree-expander outline. |
| `TreeArrowBackgroundHovered` | Hovered tree-expander interior. |
| `ListItemSeparator` | Separator between list-view groups/items where requested by the control. |
| `TabHighlightedSelected` | Selected contextual ribbon-tab accent strip. |
| `TabHighlightedHovered` | Hovered contextual ribbon-tab accent strip. |
| `TabHighlightedBackground` | Inactive contextual ribbon-tab accent strip. |

## Scrollbars, trackers and progress
| ColorPackage item | Required use |
| --- | --- |
| `ScrollBackground` | Flat scrollbar track background. |
| `TrackerBackground` | Flat inset tracker channel surface. |
| `TrackerBorder` | Single rectangular tracker channel border. |
| `ProgressBackground` | Flat empty progress track. |
| `ProgressBorder` | Single rectangular progress outline. |
| `ProgressFilling` | Solid green progress fill. |

## Menus, tooltips and ribbon
| ColorPackage item | Required use |
| --- | --- |
| `MenuBackground` | Menu content and toolbar-in-menu background. |
| `MenuBorder` | Menu popup outline and ribbon popup outline. |
| `MenuInner` | Popup underlay behind its one-pixel border and content. |
| `MenuBarBackground` | Flat pale-gray menu-bar surface. |
| `MenuBarBorderDark` | Upper line of the menu bar's two-pixel bottom edge. |
| `MenuBarBorderLight` | Lower line of the menu bar's two-pixel bottom edge. |
| `MenuSplitter` | Single-pixel horizontal menu separator and its icon-gutter continuation. |
| `ToolstripTopDark` | Upper line of the toolbar's two-pixel top edge. |
| `ToolstripTopLight` | Lower line of the toolbar's two-pixel top edge. |
| `ToolstripSplitBorder` | Single-pixel toolbar separator and immediate split-arrow separator. |
| `TooltipBackground` | Pale-yellow tooltip and keytip background. |
| `TooltipBorder` | Tooltip and keytip outline. |
| `RibbonBackground` | Flat pale-gray ribbon command area and related ribbon surfaces. |
| `RibbonBorder` | Ribbon outline, group dividers and the separate ribbon splitter. |
| `RibbonGroupText` | Ribbon group captions and popup group headings. |
| `RibbonExpandingArrow` | Ribbon group launcher arrow. |
| `RibbonExpandingArrowPressed` | Pressed ribbon group launcher arrow. |

## Custom window frame
| ColorPackage item | Required use |
| --- | --- |
| `WindowBorderActive` | Active custom-frame outline. |
| `WindowBorderInactive` | Inactive custom-frame outline. |
| `WindowCaption` | Solid active custom-frame caption. |
| `WindowCaptionInactive` | Solid inactive custom-frame caption. |
| `WindowCaptionButtonHovered` | Hovered minimize/maximize caption-button surface. |
| `WindowCaptionButtonPressed` | Pressed minimize/maximize caption-button surface. |
| `WindowClose` | Flat normal close-button surface. |
| `WindowCloseHovered` | Flat hovered close-button surface. |
| `WindowClosePressed` | Flat pressed close-button surface. |
| `WindowCloseText` | White close-button glyph. |

Header/dropdown and tree-expander colors intentionally retain the styles reused
by the original Win8 collection. The ribbon and custom frame must remain
consistent with the default light theme and legible in every state. Their
uncollected colors are documented reconstructions; personalization, compositor
effects and additional named color themes are outside this skin's scope.
