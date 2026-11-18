# Theme refresh can leave a hosted window with zero-size contents

A rebuilt theme can expose a window and UIA providers before its caption and tabs have usable bounds.

## Repro

Start `FullControlTest /D2D /Hosted` with DarkSkin. With the owner at 656 by 519, use
**Layout / Repeat**, then select Win7Skin in **Window Manager** without resizing.
Inspect the caption and the Layout tab in successive automation-service `Controls`
trees.

In fresh rebuilt PID 25932, the final Repeat test completed DarkSkin geometry,
drag and progress checks. A service-input switch to Win7Skin then left the
Controls snapshot with a 656-by-519 root, a zero-size caption and tab text
bounds `(5,5)-(5,5)`. No text had positive visible clipped bounds. The Node
adapter's ten-second wait for the Layout target failed. No owned runtime-error
dialog was found at that point.

Machine-local evidence under the Windows temporary directory is
`xgskins-winxp-final-repeat.log`,
`xgskins-winxp-final-repeat-refresh-timeout.json` and
`xgskins-winxp-final-repeat-refresh-after-resize.json`. The separate resumed
run is recorded in `xgskins-winxp-final-repeat-resume.log`.

This run used a `WTSDisconnected` Windows session. Its effect on the failure is
unknown. The original Release showcase also exposed a popup with invalid bounds.
[Hosted popup measurement](HostedPopupMeasurement.md).

## Workaround

Resize the owner from 656 by 519 to 657 by 520 and restore its original size. The
saved `Controls` trees showed 26 visible text nodes and positive Layout bounds
afterward. The test continued from the selected theme.

The `PersistencePalette` test helper waits for the old provider to retire, reacquires
the root, waits for the rebuilt tab and applies and restores the one-pixel resize. The
Node adapter adopted this bounded sequence.
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).

The resumed Win7Skin and Win8Skin tracker checks completed. A later XP palette call
raised `ElementNotAvailableException` at an unidentified stage. A fresh provider
showed XP selected and the horizontal, vertical and progress values still at 10, 5 and
10. The XP-only continuation verified tracker geometry, dragging and queued
partial/full progress. The provider failure and continuation are recorded in
`xgskins-winxp-final-repeat-xp-provider-failure.json` and
`xgskins-winxp-final-repeat-xp.log`.

## Root Cause

`RefreshThemes` rebuilds control templates through
[<GacUI-repo>/Source/Application/Controls/GuiApplication.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/Controls/GuiApplication.cpp)
and
[<GacUI-repo>/Source/Application/Controls/GuiBasicControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/Controls/GuiBasicControls.cpp).
Provider retirement or the existence of new tab providers alone should not
be used as proof that their geometry is ready for pointer tests.

The point at which layout invalidation or measurement was missed remains unknown. A
replacement provider and a nonzero outer window size can coexist with zero-size
contents.

## Proposal

Add a regression that switches skins at an unchanged window size and requires
settled positive caption/tab/control bounds, usable pointer targets and
retained application state without artificial resizing. Run it in both
connected and disconnected Windows sessions. Trace layout invalidation and
measurement after template replacement before choosing a source fix. Expose
or document a reliable readiness condition for automation. Retain the resize
workaround only as an explicit test adaptation until steady-size refresh is
verified independently.
