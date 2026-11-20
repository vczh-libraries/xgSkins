# WinVistaSkin default color package

WinVistaSkin provides one default color theme: the light Windows Vista Aero desktop
appearance. Its gray window surfaces, white content, dark text, blue control
feedback, green progress and pale-blue ribbon should remain recognizable across
all controls. Disabled, focused, selected and hovered states must remain
distinguishable. Tooltip and keytip surfaces are pale yellow.

Every skin color belongs to `winvistaskin::ColorPackage`, including transparent
colors and colors used only by a helper template. The package is declared in
[WinVistaSkin.xml](../../Source/WinVistaSkin/UI/WinVistaSkin.xml). The following names state
the purpose of each item; design references and frame details are documented in
[doc/WinVistaSkin.md](../../doc/WinVistaSkin.md).

## Native references

The Aero property sheet has a white selected tab and page. The selected tab
rises two pixels above the other headers and interrupts the `#898C95` page
outline. The inactive header has a silver face with a lighter upper half.
[Microsoft's property-tab image](https://learn.microsoft.com/en-us/windows/win32/uxguide/images/ctrl-tabs-image1.png).

Vista Explorer's selected thumbnail has a one-pixel cyan outline. On the
leftmost thumbnail, the top edge at (30, 1) is `#99DEFD`. The interior at
x = 30 runs from `#F1F8FD` near the top to `#D5EFFC` near the bottom.
[Microsoft's multiple-selection example](https://learn.microsoft.com/en-us/windows/win32/uxguide/images/ctrl-list-views-image15.png).
Vista can be identified by the stock Humpback Whale, Oryx Antelope, Toco
Toucan, Waterfall and Winter Leaves thumbnails and the light-blue details
pane. Microsoft's 2007 Explorer exhibit shows the same five photographs in
the same sequence. [Vista Photos Explorer, page 2](https://cases.justia.com/federal/district-courts/washington/wawdce/2%3A2007cv00475/142597/90/8.pdf#page=2).

The ribbon follows the Office 2007 blue scheme. Its inactive tabs show the
`#C0ECFD` strip through their backgrounds. The selected tab meets the pale-blue
panel. The highlighted command has a cream upper band, a saturated gold
`#FDD244` band just below the center and a lighter gold lower edge. These
colors are samples from the published Word image, which uses an indexed
palette. [Word 2007 Insert tab, figure 6](https://learn.microsoft.com/en-us/archive/msdn-magazine/2007/february/extend-office-2007-with-your-own-ribbon-tabs-and-controls).

## State packages

`ButtonColors` contains `Border` for the outline, `Background` for the inset
surface, `G1`/`G2` for the first gradient and `G3`/`G4` for the second gradient,
`Text` for foreground text or arrows, and `Bullet` for a check/radio mark.
Pushbuttons use the two gradients as upper/lower halves; check/radio controls
use them as nested diagonal gradients. Menu-item packages use `G1`/`G2` for the
row gradient and `G3`/`G4` for the icon-gutter bevel. A transparent mark or
background retains its RGB value while its alpha becomes zero.

| ColorPackage item | Required use |
| --- | --- |
| `ButtonNormal` | Normal pushbuttons, combo boxes, scrollbar thumbs and tracker thumbs. |
| `ButtonHovered` | Hovered pushbuttons, combo boxes, scrollbar buttons and tracker thumbs. |
| `ButtonPressed` | Pressed pushbuttons, open combo boxes, pressed scrollbar buttons and tracker thumbs. |
| `ButtonDisabled` | Disabled pushbuttons, combo boxes and scrollbar/tracker buttons. |
| `CheckedNormal` | Normal checkbox/radio frame, gradients, text and selected mark. |
| `CheckedHovered` | Hovered checkbox/radio frame, gradients, text and selected mark. |
| `CheckedPressed` | Pressed checkbox/radio frame, gradients, text and selected mark. |
| `CheckedDisabled` | Disabled checkbox/radio frame, gradients, text and selected mark. |
| `ItemNormal` | Transparent normal list/tree/gallery item and calendar-date chrome. |
| `ItemHovered` | Pale-blue hovered list/tree/gallery item and calendar-date chrome. |
| `ItemSelected` | Blue selected or pressed list/tree/gallery item and calendar-date chrome. |
| `ItemDisabled` | Transparent disabled list/tree/gallery item and calendar-date chrome with disabled foreground. |
| `TabNormal` | Normal unselected tab header. |
| `TabHovered` | Hovered or pressed unselected tab header. |
| `TabSelected` | Selected tab header joined visually to its white page. |
| `ToolstripButtonNormal` | Normal toolbar command surface. |
| `ToolstripButtonActive` | Hovered toolbar command surface. |
| `ToolstripButtonPressed` | Pressed toolbar command or open dropdown surface. |
| `ToolstripButtonSelected` | Selected toolbar command surface. |
| `ToolstripButtonDisabled` | Disabled toolbar command surface and foreground. |
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
| `RibbonButtonNormal` | Normal ribbon command chrome. |
| `RibbonButtonActive` | Gold hovered ribbon command chrome. |
| `RibbonButtonPressed` | Pressed ribbon command or open dropdown chrome. |
| `RibbonButtonSelected` | Selected ribbon command chrome. |
| `RibbonButtonDisabled` | Disabled ribbon command chrome and foreground. |

`EditorColors` contains `Border` and `Background`. It is shared by editable
text/document controls and list/tree outer borders, without changing their
item selection colors.

| ColorPackage item | Required use |
| --- | --- |
| `EditorNormal` | Gray border and white interior when neither focused nor hovered. |
| `EditorHovered` | Pale-blue border and white interior on hover. |
| `EditorFocused` | Strong blue border and white interior while focused. |
| `EditorDisabled` | Muted border and gray interior while disabled. |

## Shared surfaces and foregrounds

| ColorPackage item | Required use |
| --- | --- |
| `GeneralBackground` | Gray window client areas, plain controls, group boxes and calendar background. |
| `GeneralBorder` | General outlines and inactive window border. |
| `GeneralAccent` | Document selection background. |
| `ContentBackground` | White content surfaces and selected-page interiors. |
| `ContentBorder` | Light group-box border and shared inset surfaces. |
| `Transparent` | Fully transparent backgrounds and the alpha for hidden chrome/marks. |
| `TextNormal` | Ordinary enabled labels, control/list text, active caption text and editor caret. |
| `TextBright` | Primary document/calendar foreground, document-label caret and active shared arrows. |
| `TextSecondary` | Secondary calendar text, secondary glyphs and inactive detail text. |
| `TextDisabled` | Disabled labels, controls and glyphs. |
| `GroupText` | Enabled group-box caption. |
| `SelectionText` | Document selection foreground paired with `GeneralAccent`. |
| `ButtonBackgroundHovered` | Unfocused ribbon-gallery outline. |
| `ControlAccentHovered` | Focused ribbon-gallery outline. |
| `ArrowDisabled` | Disabled shared submenu and command arrows. |
| `ArrowAccentHovered` | Hovered shared submenu and command arrows. |

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
| `ScrollSink` | Inset shading at the edges of the scrollbar track. |
| `TrackerDark` | Dark edge of the tracker channel. |
| `TrackerLight` | Light edge of the tracker channel. |
| `ProgressBorder` | Progress outline. |
| `ProgressTrack1` | Empty progress track: upper endpoint of its top band. |
| `ProgressTrack2` | Empty progress track: lower endpoint of its top band. |
| `ProgressTrack3` | Empty progress track: upper endpoint of its middle band. |
| `ProgressTrack4` | Empty progress track: middle/lower band join. |
| `ProgressTrack5` | Empty progress track: bottom endpoint. |
| `ProgressFill1` | Filled progress: upper endpoint of its top green band. |
| `ProgressFill2` | Filled progress: lower endpoint of its top green band. |
| `ProgressFill3` | Filled progress: upper endpoint of its middle green band. |
| `ProgressFill4` | Filled progress: middle/lower green band join. |
| `ProgressFill5` | Filled progress: bottom green endpoint. |

## Menus, tooltips and ribbon

| ColorPackage item | Required use |
| --- | --- |
| `MenuBackground` | Menu content and toolbar-in-menu background. |
| `MenuBorder` | Menu popup outline and ribbon popup outline. |
| `MenuInner` | Popup underlay behind its one-pixel border and content. |
| `MenuBar1` | Upper endpoint of the menu bar's upper gradient. |
| `MenuBar2` | Lower endpoint of the menu bar's upper gradient. |
| `MenuBar3` | Upper endpoint of the menu bar's lower gradient. |
| `MenuBar4` | Lower endpoint of the menu bar's lower gradient. |
| `MenuBarBorder` | Menu-bar bottom outline. |
| `SplitterDark` | Dark edge of menu/toolbar separators. |
| `SplitterLight` | Light edge of menu/toolbar separators and group-box bevels. |
| `TooltipBackground` | Pale-yellow tooltip and keytip background. |
| `TooltipBorder` | Tooltip and keytip outline. |
| `RibbonTabStrip` | Ribbon header-row background behind the inactive tab labels. |
| `RibbonBackgroundTop` | Upper ribbon command-area background. |
| `RibbonBackgroundBottom` | Lower ribbon command-area background. |
| `RibbonBorder` | Ribbon outline and group dividers. |
| `RibbonGroupText` | Ribbon group captions and popup group headings. |
| `RibbonExpandingArrow` | Ribbon group launcher arrow. |
| `RibbonExpandingArrowPressed` | Pressed ribbon group launcher arrow. |

## Custom window frame

| ColorPackage item | Required use |
| --- | --- |
| `WindowBorderActive` | Active custom-frame outline. |
| `CaptionReflection`, `CaptionReflectionEdge` | Top and bottom stops of the gloss band across the title and caption buttons. |
| `CaptionHalo` | Light offset behind title text on colored glass. |
| `CaptionButtonTop`, `CaptionButtonBottom` | Resting caption-button face. |
| `CaptionButtonHotTop`, `CaptionButtonHotBottom` | Cyan hover highlight on minimize and maximize. |
| `CaptionButtonGlyph` | White minimize, maximize and restore marks. |
| `ProgressGlow` | Short highlight at the advancing edge of the green progress fill. |
| `WindowCaptionTop` | Pale blue at the outside edges of the active glass frame. |
| `WindowCaptionBottom` | Deeper blue toward the center of the active glass caption and the bottom frame edge. |
| `WindowCaptionInactive` | Inactive caption surface. |
| `ScrollHandlePressed` | Blue pressed minimize/maximize caption-button surface. |
| `WindowCloseTop` | Upper normal close-button gradient endpoint. |
| `WindowCloseBottom` | Lower normal close-button gradient endpoint. |
| `WindowCloseHovered` | Hovered close-button surface. |
| `WindowClosePressed` | Pressed close-button surface. |
| `WindowCloseBorder` | Close-button outline. |
| `WindowCloseText` | Close-button glyph. |

Window-frame and ribbon extensions must match the default light theme while
remaining legible in every state. They are documented reconstructions where
the old style collection has no equivalent; compositor blur and additional
named palettes are outside the scope of WinVistaSkin.
