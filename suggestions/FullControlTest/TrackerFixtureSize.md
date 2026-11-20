# The Repeat page clipped the original 21-pixel tracker thumbs

The showcase’s fixed 20-pixel tracker cells cut off the last pixel of the original
XP grip in each orientation. The original Win7Skin also requested 21 pixels
across the track. The current XP and Win7 templates fit the 20-pixel cells.

## Repro

To reproduce the historical clipping, use the original WinXPSkin tracker
template with the upstream Repeat page. In `FullControlTest /D2D /Hosted`,
select WinXPSkin and open **Layout / Repeat**. Compare each tracker’s grip with
its ancestor clip in the `Controls` tree. The original template requested an
11-by-21 horizontal grip and a 21-by-11 vertical grip.
[Original XP tracker template](https://github.com/vczh-libraries/xgSkins/blob/f196dd20c68121951b5a9e231f7c00eafa3e99a9/Source/WinXPSkin/UI/Template_Scroll.xml).

## Workaround

WinXPSkin and Win7Skin now size their grips to the available thickness and use
the same tracker minimum as DarkSkin. The Repeat page uses the upstream 20-pixel
row and column. [XP tracker templates](../../Source/WinXPSkin/UI/Template_Scroll.xml) ·
[Win7 tracker templates](../../Source/Win7Skin/UI/Template_Scroll.xml).

For the original verification, the sync script enlarged row 2 and column 2
from 20 to 21 pixels. The x32/x64 generator and merger propagated only those
two dimensions to the copied XML and generated C++. The Debug x64 build
reported zero warnings and errors. Across three runs, saved composition bounds placed
both grips inside their ancestor clips in all four skins. Both drags, retained ranges,
progress synchronization and XP’s queued partial/full six-pixel chunks with two-pixel
gaps passed.

The original, resumed and XP-only runs are in `xgskins-winxp-final-repeat.log`,
`xgskins-winxp-final-repeat-resume.log` and `xgskins-winxp-final-repeat-xp.log`. They
also record separate theme-refresh and provider interruptions.
[Theme refresh and layout](../GacUI/ThemeRefreshLayoutReadiness.md).

## Root Cause

The Repeat table fixes row 2 and column 2 at 20 pixels, independent of the active
tracker template’s measured minimum.
[<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/RepeatTabPage.xml](https://github.com/vczh-libraries/Release/blob/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/RepeatTabPage.xml).

## Proposal

Make the tracker row and column respect the active template's measured
minimum while preserving a 20-pixel fixture minimum. This would support future
skins without adding another fixed-size adjustment. Verify both orientations,
theme replacement and resizing, including skins with no explicit tracker
minimum. The other showcase dimensions should remain independent.
