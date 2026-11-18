# The Repeat page clips 21-pixel tracker thumbs in 20-pixel cells

The showcase’s fixed tracker cells cut off the last pixel of the XP grip in each
orientation. Win7Skin also requests a 21-pixel cross-axis size.

## Repro

Use the original FullControlTest Repeat page, before the local synchronization
adjustment. In `FullControlTest /D2D /Hosted`, select WinXPSkin and open
**Layout / Repeat**. Inspect each tracker’s grip and ancestor clip in the `Controls`
tree. XP requests an 11-by-21 horizontal grip and a 21-by-11 vertical grip. The
original row and column each offered only 20 pixels across the track.

## Workaround

The local synchronization script changes table row index 2 and column index 2 from 20
to 21 pixels. It matches both full declarations before editing. A plain `MinSize` cell
could instead shrink the DarkSkin tracker, whose template supplies no equivalent
cross-axis minimum. [syncProj.ps1](../../scripts/Windows/syncProj.ps1).

Each upstream declaration matched once. The x32/x64 generator and merger propagated
only those two dimensions to the copied XML and generated C++. The Debug x64 build
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
