# FullControlTest tracker fixture dimensions

The upstream [Release/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/RepeatTabPage.xml](https://github.com/vczh-libraries/Release/blob/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/RepeatTabPage.xml)
places the horizontal tracker in a fixed 20-pixel row and the vertical tracker
in a fixed 20-pixel column. WinXPSkin's thumb artwork needs 21 pixels across the
track. A saved Controls snapshot confirmed that the parent cells still clip
both trackers to 20 pixels, cutting off the final edge. Win7Skin also requests
a 21-pixel tracker dimension.

## Local synchronization adjustment

[syncProj.ps1](../scripts/Windows/syncProj.ps1) applies two guarded replacements
after copying the showcase: table row index 2 grows from 20 to 21 pixels for
the horizontal tracker, and column index 2 grows from 20 to 21 pixels for the
vertical tracker. The scrollbar rows/columns and progress row remain 20 pixels.
The complete row and column declarations are matched, so changes to the
upstream fixture stop synchronization for review. Existing newline handling
is preserved. No upstream source or skin artwork changes.

The fixed 21-pixel size accommodates the current skins with a one-pixel
fixture adjustment. Merely replacing the fixed dimensions with `MinSize`
could shrink the DarkSkin trackers, whose templates do not declare an
equivalent cross-axis minimum.

The replacement was checked against the current upstream text in memory:
each expected block occurs once, and only the two tracker dimension lines
change. Synchronization and x32/x64 generation/merge completed successfully:
the copied XML and generated C++ each change only the two dimensions from
20 to 21. The Debug x64 rebuild completed with zero warnings and errors.
Runtime coverage completed across three preserved runs: original DarkSkin,
resumed Win7Skin/Win8Skin, and an XP-only continuation. Independent saved
geometry confirms 21-pixel tracker cells and both grips inside ancestor clips
for all four skins, including XP's 11-by-21 and 21-by-11 grips. Horizontal and
vertical drags, retained ranges, read-only progress synchronization, and XP's
queued partial/full 6-pixel chunks with 2-pixel gaps passed. These are
composition and interaction checks, not native raster evidence.

The original refresh-layout timeout and a later XP palette helper
`ElementNotAvailableException` remain recorded; neither was erased by the
continuations. Fresh selected-XP state and retained ranges were checked before
continuing without replaying the palette action. See
[ThemeRefreshLayoutReadiness.md](ThemeRefreshLayoutReadiness.md) for the
workaround and evidence limits. The separate logs under the Windows temporary
directory are `xgskins-winxp-final-repeat.log`,
`xgskins-winxp-final-repeat-resume.log` and `xgskins-winxp-final-repeat-xp.log`.

## Proposed upstream change

Make the tracker row and column respect the active template's measured
minimum while preserving a 20-pixel fixture minimum. This would support future
skins without adding another fixed-size adjustment. Verify both orientations,
theme replacement and resizing, including skins with no explicit tracker
minimum. The other showcase dimensions should remain independent.
