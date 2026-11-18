# WinXPSkin default color package

WinXPSkin provides one default palette: blue Windows XP Luna. Beige client
surfaces, white content, subtly rounded controls, orange hot accents, blue
scrollbars, green progress chunks and a vivid blue caption should be
recognizable. Disabled, focused, selected and hovered states must remain
legible and distinct. Tooltips and keytips use pale-yellow surfaces.

Every skin color belongs to `winxpskin::ColorPackage`, including transparency
and helper artwork. The package is declared in
[WinXPSkin.xml](../../Source/WinXPSkin/UI/WinXPSkin.xml). The tables below define
required uses; provenance and integration belong in
[doc/WinXPSkin.md](../../doc/WinXPSkin.md).

`ButtonColors` has six fields: `Border` for the outer outline, `Inner` for
its inner accent, `G1`/`G2` for the face gradient, `Text` for text/arrows or
grip highlights, and `Bullet` for marks or auxiliary chrome. Flat faces use
equal gradient endpoints. Transparent normal toolbar/ribbon states must reveal the intended
background, without painting an opaque rectangle over it.

`EditorColors` has `Border` and `Background`, shared by editors and the
outer borders of list/tree controls. It does not define item selection.

## State packages

| ColorPackage item | Required use |
| --- | --- |
| `ButtonNormal` | Normal pushbutton border, inner rim, cream face and foreground. |
| `ButtonHovered` | Hovered pushbutton with an orange inner rim. |
| `ButtonFocused` | Enabled, focused pushbutton at rest, with a blue inner rim. |
| `ButtonPressed` | Pressed pushbutton with an inset face. |
| `ButtonDisabled` | Disabled pushbutton face, border and foreground. |
| `ItemNormal` | Transparent normal list/tree/gallery item and calendar-date chrome. |
| `ItemHovered` | Pale-blue hovered list/tree/gallery item and calendar-date chrome. |
| `ItemSelected` | Pale selected or pressed list/tree/gallery item and calendar-date chrome with a blue outline. |
| `ItemDisabled` | Muted disabled list/tree/gallery item and calendar-date chrome. |
| `CheckedNormal` | Normal check/radio frame, inset face, text and selected mark. |
| `CheckedHovered` | Hovered check/radio frame, inset face, text and selected mark. |
| `CheckedPressed` | Pressed check/radio frame, inset face, text and selected mark. |
| `CheckedDisabled` | Disabled check/radio frame, inset face, text and selected mark. |
| `ToolstripButtonNormal` | Normal toolbar command surface. |
| `ToolstripButtonActive` | Hovered toolbar command surface. |
| `ToolstripButtonPressed` | Pressed toolbar command or open dropdown surface. |
| `ToolstripButtonSelected` | Selected toolbar command surface and checked menu-command icon well. |
| `ToolstripButtonDisabled` | Disabled toolbar command surface and foreground. |
| `ScrollHandleNormal` | Normal blue scrollbar thumb. |
| `ScrollHandleActive` | Lighter hovered blue scrollbar thumb. |
| `ScrollHandlePressed` | Pressed blue scrollbar thumb. |
| `ScrollHandleDisabled` | Disabled thumb palette. The scrollbar hides the thumb while disabled. |
| `ScrollArrowNormal` | Normal scrollbar-arrow, combo-arrow and gallery-scroll button surface with a blue arrow. |
| `ScrollArrowActive` | Hovered scrollbar-arrow, combo-arrow and gallery-scroll button surface with a blue arrow. |
| `ScrollArrowPressed` | Pressed scrollbar-arrow, combo-arrow and gallery-scroll button surface with a dark arrow. |
| `ScrollArrowDisabled` | Disabled scrollbar-arrow, combo-arrow and gallery-scroll button surface with muted arrow. |
| `TrackerNormal` | Normal tracker thumb with a cream face and green accents. |
| `TrackerHovered` | Hovered tracker thumb with orange accents. |
| `TrackerPressed` | Pressed tracker thumb with muted green accents and inset shading. |
| `TrackerDisabled` | Disabled tracker thumb with muted beige-gray accents. |
| `MenuBarButtonNormal` | Normal menu-bar command state. |
| `MenuBarButtonActive` | Hovered menu-bar command state. |
| `MenuBarButtonPressed` | Pressed menu-bar command or open submenu state. |
| `MenuBarButtonDisabled` | Disabled menu-bar command state. |
| `MenuItemButtonNormal` | Normal white menu row and glyphs. |
| `MenuItemButtonNormalActive` | Hovered or open normal menu row. |
| `MenuItemButtonSelected` | Checked menu row at rest, retaining the white face beside its check glyph or selected icon well. |
| `MenuItemButtonSelectedActive` | Hovered or open checked menu row, using blue with white foreground. |
| `MenuItemButtonDisabled` | Disabled menu row and foreground. |
| `MenuItemButtonDisabledActive` | Hovered disabled menu row. |
| `TabNormal` | Normal unselected tab header. |
| `TabHovered` | Hovered or pressed unselected tab header. |
| `TabSelected` | Selected tab header joined visually to its near-white page. |
| `TabDisabled` | Disabled tab face, outline and foreground. |
| `RibbonButtonNormal` | Transparent normal command face shared with the default toolstrip palette. |
| `RibbonButtonActive` | Pale blue hovered command face with the toolstrip’s blue outline. |
| `RibbonButtonPressed` | Deeper blue toolstrip face for a pressed command or open dropdown. |
| `RibbonButtonSelected` | Selected command face with the toolstrip’s gray-blue fill and blue outline. |
| `RibbonButtonDisabled` | Transparent disabled ribbon command chrome with disabled foreground. |

## Editor packages

| ColorPackage item | Required use |
| --- | --- |
| `EditorNormal` | Blue-gray border and white interior in the normal state. |
| `EditorHovered` | Hovered editor border and white interior. |
| `EditorFocused` | Blue-gray border and white interior while focused; the default border stays unchanged. |
| `EditorDisabled` | Blue-gray border and gray-beige interior while disabled. |

## Shared surfaces and foregrounds

| ColorPackage item | Required use |
| --- | --- |
| `GeneralBackground` | Beige window client areas, generic scroll views, tracker surrounds, group boxes and calendar background. |
| `GeneralBorder` | General control outlines and generic scroll-view borders. |
| `GeneralAccent` | Document selection background and focused combo-box text background. |
| `ContentBackground` | White document, list and tree content surfaces. |
| `Transparent` | Fully transparent backgrounds and the alpha for hidden chrome/marks. |
| `TextNormal` | Ordinary enabled labels, control/list text, document-label/viewer carets and shared split arrows. |
| `TextBright` | Default document/calendar foreground and text-box caret. |
| `TextSecondary` | Secondary calendar text for adjacent-month dates. |
| `TextDisabled` | Disabled labels, controls and glyphs. |
| `GroupText` | Enabled group-box caption. |
| `GroupBorder` | Subtle group-box border. |
| `SelectionText` | Document selection and focused combo-box text foreground, paired with `GeneralAccent`. |
| `ButtonBackgroundHovered` | Unfocused ribbon-gallery outline. |
| `ControlAccentHovered` | Focused ribbon-gallery outline. |

## Lists, headers, trees and tabs

| ColorPackage item | Required use |
| --- | --- |
| `HeaderBackground` | Normal list-view header face and upper endpoint of its lower edge. |
| `HeaderBackgroundHovered` | Hovered list-view header face. |
| `HeaderBackgroundPressed` | Pressed list-view header background. |
| `HeaderSeparatorTop` | Normal header's lower edge and dark vertical separator line. |
| `HeaderSeparatorLight` | Light vertical separator line beside the dark header separator. |
| `HeaderBorderPressed` | Pressed header and active header-dropdown border, plus sort arrows. |
| `HeaderBorderHovered` | Orange lower edge of a hovered header. |
| `HeaderGradientPressedTop` | Upper inset edge of a pressed header. |
| `HeaderGradientHoveredTop` | Upper endpoint of the hovered header's orange lower-edge gradient. |
| `HeaderGradientHoveredBottom` | Lower endpoint of the hovered header's orange lower-edge gradient. |
| `HeaderText` | Enabled header text and dropdown arrow. |
| `HeaderDropDownTop` | Upper endpoint of the hovered, pressed or selected header-dropdown gradient. |
| `HeaderDropDownBottom` | Lower endpoint of the hovered, pressed or selected header-dropdown gradient. |
| `TreeBorder` | Outline of the tree expander's square box. |
| `TreeGradientTop` | Light upper endpoint of the boxed tree expander's diagonal face gradient. |
| `TreeGradientBottom` | Lower endpoint of the boxed tree expander's diagonal face gradient. |
| `TreeGlyph` | Plus/minus glyph inside an enabled tree expander. |
| `ListItemSeparator` | Separator between list-view groups/items where requested by the control. |
| `ComboBorder` | Enabled combo-box outer outline. |
| `ComboDisabledBorder` | Disabled combo-box outer outline. |
| `ComboBackground` | White combo-box content face. |
| `ComboDisabledBackground` | Disabled combo-box content face. |
| `TabHotBorder` | Orange top edge of a selected or hovered tab. |
| `TabHotAccent` | Light inset top accent beneath the orange tab edge. |
| `TabContentBottom` | Lower endpoint of an ordinary tab page's cream gradient. |
| `TabHighlightedSelected` | Selected contextual ribbon-tab accent strip. |
| `TabHighlightedHovered` | Hovered contextual ribbon-tab accent strip. |
| `TabHighlightedBackground` | Inactive contextual ribbon-tab accent strip. |

## Scrollbars, trackers and progress

| ColorPackage item | Required use |
| --- | --- |
| `ScrollBackground` | Scrollbar shaft background. |
| `TrackerBackground` | Flat inset tracker channel surface. |
| `TrackerBorder` | Rectangular tracker-channel border. |
| `RadioBulletLight` | Light upper endpoint of an enabled selected radio mark. |
| `ProgressBackground` | Flat empty progress track. |
| `ProgressBorder` | Subtly rounded progress-track outline. |
| `ProgressFillingLight` | Light upper edge of each green progress chunk. |
| `ProgressFilling` | Saturated green center of each progress chunk. |
| `ProgressFillingBottom` | Light lower edge of each green progress chunk. |

## Menus, tooltips and ribbon

| ColorPackage item | Required use |
| --- | --- |
| `MenuBackground` | Menu content and toolbar-in-menu background. |
| `MenuBorder` | Menu popup outline and ribbon popup outline. |
| `MenuInner` | Popup underlay behind its one-pixel border and content. |
| `MenuBarBackground` | Beige menu-bar surface. |
| `MenuBarBorderDark` | Upper line of the menu bar's two-pixel bottom edge. |
| `MenuBarBorderLight` | Lower line of the menu bar's two-pixel bottom edge. |
| `MenuSplitter` | Single-pixel horizontal menu separator across the command-text area, leaving the icon area blank. |
| `ToolstripTopDark` | Upper line of the toolbar's two-pixel top edge. |
| `ToolstripTopLight` | Lower line of the toolbar's two-pixel top edge. |
| `ToolstripSplitBorder` | Dark toolbar separator line and immediate split-arrow separator. |
| `ToolstripSplitLight` | Light toolbar separator line beside its dark edge. |
| `TooltipBackground` | Pale-yellow tooltip and keytip background. |
| `TooltipBorder` | Tooltip and keytip outline. |
| `RibbonBackground` | Beige invented ribbon command area and related ribbon surfaces. |
| `RibbonBorder` | Ribbon outline, group dividers and the separate ribbon splitter. |
| `RibbonGroupText` | Ribbon group captions and popup group headings. |
| `RibbonExpandingArrow` | Ribbon group launcher arrow. |
| `RibbonExpandingArrowPressed` | Pressed ribbon group launcher arrow. |

## Custom window frame

| ColorPackage item | Required use |
| --- | --- |
| `WindowFrameActive` | Active blue custom-frame sides and lower edge. |
| `WindowFrameInactive` | Muted blue inactive custom-frame sides and lower edge. |
| `WindowBorderActive` | Active custom-frame outline. |
| `WindowBorderInactive` | Inactive custom-frame outline. |
| `WindowCaptionTop` | Light upper edge of the active blue caption. |
| `WindowCaptionBodyTop` | Upper endpoint of the main active-caption gradient. |
| `WindowCaptionBodyBottom` | Lower endpoint of the main active-caption gradient. |
| `WindowInactiveTop` | Light upper edge of the inactive caption. |
| `WindowInactiveBodyTop` | Upper endpoint of the main inactive-caption gradient. |
| `WindowInactiveBodyBottom` | Lower endpoint of the main inactive-caption gradient. |
| `WindowCaptionText` | Active enabled caption text and caption-button glyphs. |
| `WindowCaptionTextInactive` | Inactive or disabled caption text and caption-button glyphs. |
| `WindowCaptionShadow` | One-pixel shadow beneath active caption text. |
| `CaptionNormalTop` | Upper endpoint of a normal blue minimize/maximize button. |
| `CaptionNormalBottom` | Lower endpoint of a normal blue minimize/maximize button. |
| `CaptionHoveredTop` | Upper endpoint of a hovered blue caption button. |
| `CaptionHoveredBottom` | Lower endpoint of a hovered blue caption button. |
| `CaptionPressedTop` | Upper endpoint of a pressed blue caption button. |
| `CaptionPressedBottom` | Lower endpoint of a pressed blue caption button. |
| `CaptionInactiveTop` | Upper endpoint of inactive minimize/maximize faces and disabled caption-button faces. |
| `CaptionInactiveBottom` | Lower endpoint of inactive minimize/maximize faces and disabled caption-button faces. |
| `CaptionRim` | Light outline around active caption buttons. |
| `CaptionRimInactive` | Muted outline around inactive caption buttons. |
| `CloseNormalTop` | Upper endpoint of the normal red close button. |
| `CloseNormalBottom` | Lower endpoint of the normal red close button. |
| `CloseInactiveTop` | Upper endpoint of the muted red close button on an inactive window. |
| `CloseInactiveBottom` | Lower endpoint of the muted red close button on an inactive window. |
| `CloseHoveredTop` | Upper endpoint of the hovered red close button. |
| `CloseHoveredBottom` | Lower endpoint of the hovered red close button. |
| `ClosePressedTop` | Upper endpoint of the pressed red close button. |
| `ClosePressedBottom` | Lower endpoint of the pressed red close button. |

The ribbon and custom frame extend the Luna art design to current GacUI
controls. Their visual approximations must remain consistent and legible.
List/tree/grid/calendar item selection uses a pale fill where the existing
control contract does not expose selected foregrounds; menus and document
selection use blue with white text. Additional named palettes, desktop effects
and personalization are outside this skin's scope.

Disabled document-based editors use the gray-beige frame fill while retaining
their configured document foregrounds. Plain text therefore stays black;
explicit document formatting must remain intact. The current foreground
limitation and proposed API support are documented in
[DisabledDocumentForeground.md](../../suggestions/GacUI/DisabledDocumentForeground.md).
