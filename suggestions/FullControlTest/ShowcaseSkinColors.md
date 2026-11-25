# Fixed DarkSkin colors make showcase text hard to read under light skins

Several showcase pages combine fixed DarkSkin foregrounds or backgrounds with colors from the active theme.

## Repro

Run `FullControlTest /D2D /Hosted` and switch from DarkSkin to a light skin in
**Window Manager**. Inspect the date readouts in **Misc / DatePicker** and the
custom swipe rows on **Misc / TouchingList**.

Affected upstream resources are in
[<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest](https://github.com/vczh-libraries/Release/tree/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest).

## Workaround

N/A

## Root Cause

The date readouts set their text color to white. The swipe-list template uses
the DarkSkin palette for its background and the active skin for its item text.
[<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/DatePickerTabPage.xml](https://github.com/vczh-libraries/Release/blob/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/DatePickerTabPage.xml),
[<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/TouchingListTabPage.xml](https://github.com/vczh-libraries/Release/blob/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/TouchingListTabPage.xml).

## Proposal

Use themed `Label` controls for the date readouts. Draw the swipe row's text
and background from the same palette.

Check the date readouts and swipe rows after switching between DarkSkin and a light skin.
