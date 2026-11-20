# Win7Skin default color package

Win7Skin provides one default color theme: the light Windows 7 desktop
appearance. Its gray window surfaces, white content, dark text, blue control
feedback, green progress and pale-blue ribbon should remain recognizable across
all controls. Disabled, focused, selected and hovered states must remain
distinguishable. Tooltip and keytip surfaces are pale yellow.

Every skin color belongs to `win7skin::ColorPackage`, including transparent
colors and colors used only by a helper template. The package is declared in
[Win7Skin.xml](../../Source/Win7Skin/UI/Win7Skin.xml). The following names state
the purpose of each item; technical provenance and integration are documented in
[doc/Win7Skin.md](../../doc/Win7Skin.md).

## Native references

The Aero property sheet has a white selected tab and page. In Microsoft's
396 × 36 example, the selected tab begins at y = 5 and the other tabs at
y = 7. The `#898C95` page edge at y = 25 stops under the selected tab.
The inactive face at x = 100 runs from `#EBEBEB` to `#CBCBCB`.
[Microsoft's property-tab image](https://learn.microsoft.com/en-us/windows/win32/uxguide/images/ctrl-tabs-image1.png).

In the Windows 7 Documents Library, the selected Windows 7 logo thumbnail
uses a blue gradient. Its upper fill at (350, 352) is
`#DAEBFD` and its lower fill at (350, 432) is `#CADDFE`. These JPEG samples
are close to the existing `ItemSelected` fill.
[Microsoft's Windows 7 Documents Library](https://learn.microsoft.com/en-us/windows/win32/win7devguide/images/windows7-11.jpg).

In Windows 7 Paint, inactive ribbon tabs sit directly on the `#DFE9F5`
strip. The selected Home tab joins the panel, which runs from `#F5FBFF`
to `#DCE7F5`. The selected text tool's fill at x = 224 changes from
`#F8D4A9` at y = 51 to orange at the center and pale yellow near the
lower edge. [Microsoft's Windows 7 Paint image](https://learn.microsoft.com/en-us/windows/win32/windowsribbon/images/overviews/screenshot-paint-win7transparency-mirror.png).

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
| `ButtonBackgroundHovered` | Hovered caption-button surface and unfocused ribbon-gallery outline. |
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
| `WindowCaptionTop` | Upper active caption gradient endpoint. |
| `WindowCaptionBottom` | Lower active caption gradient endpoint. |
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
named palettes are outside the scope of Win7Skin.
