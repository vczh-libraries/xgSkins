# Theme refresh needs settled layout before geometry tests

In fresh rebuilt PID 25932, the final Repeat test completed DarkSkin geometry,
drag and progress checks. A service-input switch to Win7Skin then left the
Controls snapshot with a 656-by-519 root, a zero-size caption and tab text
bounds `(5,5)-(5,5)`. No text had positive visible clipped bounds. The Node
adapter's ten-second wait for the Layout target failed. No owned runtime-error
dialog was found at that point.

One UIA resize to 657 by 520 followed by restoration to 656 by 519 recovered
26 visible text nodes and positive Layout bounds. The palette action was not
replayed. Independent comparison of the before/after snapshots confirmed
both the zero-size layout and recovery at the original root dimensions.
The Windows session was `WTSDisconnected`; this is context, not proof that
the environment caused the failure. The underlying source cause is unproven.

Machine-local evidence under the Windows temporary directory is
`xgskins-winxp-final-repeat.log`,
`xgskins-winxp-final-repeat-refresh-timeout.json` and
`xgskins-winxp-final-repeat-refresh-after-resize.json`. The separate resumed
run is recorded in `xgskins-winxp-final-repeat-resume.log`.

The existing `PersistencePalette` helper in
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
already waits for the old palette provider to retire, reacquires the root,
waits for a rebuilt tab, then applies and restores a one-pixel resize with
Controls snapshots between steps. The initial Node adapter omitted that
layout adjustment. Its continuation now delegates palette changes to this
helper instead of replaying the already completed switch; request and
readiness waits remain bounded. Keep the original failure distinct from
results obtained using the workaround. No skin, application or upstream
source is patched for this behavior.

The resumed run completed Win7Skin and Win8Skin tracker checks, then the XP
palette helper raised `ElementNotAvailableException` at an unrecorded stage.
Fresh inspection confirmed XP selected and retained horizontal/vertical/
progress values of 10/5/10. No palette action was replayed. An XP-only
continuation completed its tracker geometry, drag, retention and queued
partial/full progress checks; together with the earlier runs this completes
four-skin fixture coverage. It does not convert either interrupted operation
into a passing call or establish the cause of the provider failure. Evidence
includes `xgskins-winxp-final-repeat-xp-provider-failure.json` and
`xgskins-winxp-final-repeat-xp.log` under the Windows temporary directory.

`RefreshThemes` rebuilds control templates through
[GacUI/Source/Application/Controls/GuiApplication.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/Controls/GuiApplication.cpp)
and
[GacUI/Source/Application/Controls/GuiBasicControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/Controls/GuiBasicControls.cpp).
Provider retirement or the existence of new tab providers alone should not
be used as proof that their geometry is ready for pointer tests.

Add a regression that switches skins at an unchanged window size and requires
settled positive caption/tab/control bounds, usable pointer targets and
retained application state without artificial resizing. Run it in both
connected and disconnected Windows sessions. Trace layout invalidation and
measurement after template replacement before choosing a source fix; expose
or document a reliable readiness condition for automation. Retain the resize
workaround only as an explicit test adaptation until steady-size refresh is
verified independently.

## Popup measurement in hosted automation

In `FullControlTest /D2D /Hosted`, the File popup in an unmodified Release
showcase reported zero width and height even though its menu rows existed.
After a round trip to DarkSkin in the rebuilt Debug showcase, the same popup
reported a 1-by-1 window with measured text outside its clip. Resizing the
owner while the popup was open gave it a 201-by-56 rectangle.

Some Win8Skin service checks similarly needed a one-pixel owner resize before
the popup or a newly selected tab exposed its contents at usable coordinates.
The checks then inspected the rendered frame, fill, row colors and bounds.
Windows UI Automation could also expand File and its Save as submenu directly.
Include hidden and reopened popups in the steady-size layout regression above.
