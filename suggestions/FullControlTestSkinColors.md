# FullControlTest colors when switching skins

The upstream showcase is written for DarkSkin. Several raw text elements use
white text independently of the active skin. With a light skin, the date readouts,
localization instructions, ribbon gallery captions, and font-dialog sample can
become unreadable.

Affected upstream resources are in
[Release-repo/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest](https://github.com/vczh-libraries/Release/tree/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest).

## Local synchronization adjustments

`scripts/Windows/syncProj.ps1` applies the following changes after copying the
showcase, so running synchronization preserves the corrections:

- `DatePickerTabPage.xml`, `LocalizedStringsTabPage.xml`, and
  `LocalizedDialogsTabPage.xml`: use `Label` for ordinary readouts and
  instructions, allowing the active label template to select its text color.
- `LocalizedDialogsTabPage.xml`: use `Label.TextColor` for the named font-dialog
  sample. The sample still accepts the font and color chosen in the dialog.
- `DocumentEditorRibbon.xml`: read the active theme color from an empty hidden
  `Label` for raw style samples and captions. Explicit document-style colors continue to override the
  sample color. Use `Label` for the tooltip caption and search prompt.
- `VerticalTabTemplate.xml`: keep the explicitly authored DarkSkin navigation
  headers, but restrict their dark background to the header column. The content
  area inherits the active window surface, so standard controls and labels use
  compatible foreground and background colors.
- `TouchingListTabPage.xml`: keep this custom swipe-row demonstration's explicit
  DarkSkin surfaces and use its matching normal text color. Previously it mixed
  the active skin's item text color with fixed DarkSkin backgrounds.

The patches check their expected upstream text and stop synchronization if it
changes, so an upstream revision cannot silently discard these adjustments.
No upstream source or DarkSkin palette is modified.

## Proposed upstream changes

Use theme-provided `Label` controls for ordinary application text, and obtain gallery text colors from
that theme. `GuiBindableRibbonGalleryList` does not initialize the inherited
`TextListItemTemplate.TextColor`, so it is not a reliable palette source. Keep explicit document-style colors only where displaying those
colors is the purpose of the sample.

Separate the vertical navigation header's custom background from the page
content background. The swipe-list demonstration should either retain its own
complete palette, including text, or obtain its foreground, background, and
selection paint from a theme-independent template contract. Mixing one skin's
background with another skin's text is insufficient.

Verify the date readouts, localization instructions, ribbon style gallery,
font-dialog sample, vertical-tab page content, and swipe-list text after
switching between DarkSkin and a light skin. Explicitly selected font-dialog
colors remain user choices and are not automatically adjusted for contrast.

## Theme-dependent verification expectations

The upstream
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
`DocumentStyles` checks also assume white ordinary text. That is appropriate for
DarkSkin, while the Win7Skin document baseline is black. A portable style-gallery
check should obtain the current baseline foreground from a plain active editor,
while retaining exact assertions for explicitly colored document styles. The
local verification adapter follows that rule; no upstream test source is edited.
