# Fixed DarkSkin colors make showcase text hard to read under light skins

Several showcase pages combine fixed DarkSkin foregrounds or backgrounds with colors from the active theme.

## Repro

Run `FullControlTest /D2D /Hosted` and switch from DarkSkin to a light skin in
**Window Manager**. Inspect the date readouts in **Misc / DatePicker**, the
ribbon Search prompt, the Layout page beside the vertical tab
headers, and the custom swipe rows on **Misc / TouchingList**.

Affected upstream resources are in
[<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest](https://github.com/vczh-libraries/Release/tree/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest).

## Workaround

N/A

## Root Cause

The original raw text elements set white explicitly. The vertical-tab background also
covers the page content, and the swipe-list template combines a fixed dark surface
with the active item text color.
[<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/DocumentEditorRibbon.xml](https://github.com/vczh-libraries/Release/blob/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/DocumentEditorRibbon.xml).

## Proposal

Use themed `Label` controls for the date readouts and the ribbon Search prompt.
Limit the dark vertical-tab background to the header column and let
the content inherit the window surface. Draw the swipe row's text and background
from the same palette.

Check the date readouts, Search prompt,
vertical-tab content and swipe rows after switching between DarkSkin and a light skin.
