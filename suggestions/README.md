# Suggestions

<!-- When a new first level category is added, keep the following order: Vlpp, VlppOS, VlppRegex, VlppReflection, VlppParser2, Workflow, GacUI, others -->

## Workflow

- [A bound polygon point list can crash GacGen during template validation.](Workflow/BoundPolygonPoints.md)

## GacUI

- **P1**
  - [After a theme change, a hosted window can report its full size while its caption and tabs have zero-size bounds.](GacUI/ThemeRefreshLayoutReadiness.md): Need to review the workaround
  - [The live ribbon gallery and editor document can both report keyboard focus in the same window.](GacUI/RetainedLogicalFocus.md): Need a proper repro
  - [Reloading visible styles retains the expanded movie-row height. FullControlTest now replaces the arranger on a level change.](GacUI/ResponsiveListRowHeight.md)
  - [A disabled document editor can keep its enabled text color even as its background changes.](GacUI/DisabledDocumentForeground.md)[After an edit, skin change and undo, a private document save can lose the final paragraph’s explicit font face and its bold-off and italic-off settings.](GacUI/DocumentUndoSerialization.md)
- **NEED CLARIFICATION**
  - [A hosted File menu can open at zero size or one pixel square, clipping rows that already have measured bounds.](GacUI/HostedPopupMeasurement.md)
  - [Restoring focus to a destroyed hosted window can crash FullControlTest.](GacUI/HostedWindowLastFocusedWindow.md)
  - [A finite color animation can stop at an intermediate color after its duration has elapsed.](GacUI/FiniteAnimationEndpoint.md)
  - [Adding XP progress chunks during layout can halt the running Debug showcase before the first chunk appears.](GacUI/ProgressChunkLayoutMutation.md): Is it an existing issue in current implementation?
- **NEED REPRO**
  - [A selected calendar day keeps its month’s text color when the button changes to its selection color.](GacUI/SelectedCalendarDayForeground.md)
- **TO BE TRIAGED**
  - [Selecting a list or tree row changes its background while its label keeps the normal text color.](GacUI/SelectedItemForeground.md)
  - [GDI draws partial-alpha fills as opaque. Win11Skin uses solid hover colors.](GacUI/GdiTabHoverOpacity.md)

## FullControlTest

### Showcase controls

- [Black editor command icons and blue Website links are hard to see on dark backgrounds.](FullControlTest/EditorAndGridContrast.md)
- [On light skins, date readouts and swipe rows can be hard to read.](FullControlTest/ShowcaseSkinColors.md)
- [Pressing Ctrl+A in the ribbon Search field selects the central document.](FullControlTest/SingleLineShortcutRouting.md)
- [The Style gallery popup exposes an unnamed UI Automation toggle with no command to reapply the selected style.](FullControlTest/GalleryItemActivation.md)
- [The Repeat page’s 20-pixel cells clipped one pixel from the original 21-pixel XP tracker thumbs.](FullControlTest/TrackerFixtureSize.md)

### Verification

- [The document-style test expects white text and rejects Win7Skin’s black default foreground.](FullControlTest/DocumentStyleBaseline.md)
- [The editor test can lose its UI Automation element while looking for the Load dialog after saving a hyperlink document.](FullControlTest/ModalDiscovery.md)
- [Resuming an editor test in the same output directory can leave it waiting at an overwrite prompt.](FullControlTest/ResumedSaveOverwrite.md)
- [The Window test can time out with the original Toolstrip document still present after Ctrl+A and Delete.](FullControlTest/ToolstripDocumentClear.md)
- [The keyboard test can stop at a process-wide idle check before it types into the target field.](FullControlTest/KeyboardPayloadFieldReadiness.md)
- [A resumed document-touch test can stop at an idle or window-size check before it exercises the gestures.](FullControlTest/DocumentTouchViewport.md)
- [Reading a UI Automation element’s name for a diagnostic can interrupt the document-touch test during pattern lookup.](FullControlTest/TouchPatternDiagnostics.md)
- [A large window can fit every ListView row, leaving the touch-scroll test with no scroll range.](FullControlTest/TouchingListViewViewport.md)
- [The momentum test throws when it resets the vertical scroll position of a list whose rows all fit.](FullControlTest/TouchListScrollReset.md)
- [Rerunning the TextList test after switching skins can leave it in Radio mode when the test expects Text mode.](FullControlTest/TextListInitialMode.md)
- [The EasyLayout table test requests palette names such as Ember that the extension’s selector does not offer.](FullControlTest/EasyLayoutPaletteNames.md)
- [After a theme change, the EasyLayout test can report the Window Manager tab missing before its new provider appears.](FullControlTest/RebuiltThemeProviders.md)
