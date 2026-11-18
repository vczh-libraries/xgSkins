# Fixed DarkSkin colors make showcase text hard to read under light skins

Several showcase pages combine fixed DarkSkin foregrounds or backgrounds with colors from the active theme.

## Repro

Use the unadjusted upstream showcase resources in `FullControlTest /D2D /Hosted`.
Switch from DarkSkin to a light skin in **Window Manager**. Inspect the date readouts
in **Misc / DatePicker**, the localization instructions and font-dialog sample, the
ribbon style gallery and Search prompt, the Layout page beside the vertical tab
headers, and the custom swipe rows on **Misc / TouchingList**. The local sync script
already adjusts these resources.

Affected upstream resources are in
[<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest](https://github.com/vczh-libraries/Release/tree/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest).

## Workaround

The local sync script reapplies these changes after copying the showcase and checks
each expected upstream declaration first.
[syncProj.ps1](../../scripts/Windows/syncProj.ps1).

- In `DatePickerTabPage.xml`, `LocalizedStringsTabPage.xml` and
  `LocalizedDialogsTabPage.xml`, ordinary readouts and instructions use themed `Label`
  controls.
- The font-dialog sample uses `Label.TextColor` and accepts the font and color chosen in the dialog.
- In `DocumentEditorRibbon.xml`, a hidden `Label` supplies the active text color for
  raw style samples and captions. Explicit document-style colors take precedence. The
  tooltip caption and Search prompt use themed labels.
- In `VerticalTabTemplate.xml`, the dark header background covers just the header
  column. Page content inherits the active window surface.
- In `TouchingListTabPage.xml`, the custom swipe row uses the normal text color from
  the same DarkSkin palette as its fixed surfaces.

## Root Cause

The original raw text elements set white explicitly. The vertical-tab background also
covers the page content, and the swipe-list template combines a fixed dark surface
with the active item text color. `GuiBindableRibbonGalleryList` leaves the inherited
`TextListItemTemplate.TextColor` uninitialized, so that property does not supply a
usable theme color to the gallery.
[<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/DocumentEditorRibbon.xml](https://github.com/vczh-libraries/Release/blob/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/DocumentEditorRibbon.xml).

## Proposal

Use themed labels and the active theme’s text color for ordinary samples. Keep
explicit colors where displaying a document style or a user-selected font-dialog color
is the purpose of the sample. Give the vertical header and content separate
backgrounds. The custom swipe row should take its foreground, background and selection
colors from a consistent palette.

Check the date readouts, localization instructions, gallery, font-dialog sample,
vertical-tab content and swipe rows after switching between DarkSkin and a light skin.
[Document-style test expectations](DocumentStyleBaseline.md).
