# Win7Skin verification record

Verification on 2026-11-18 used Windows, `Debug|x64`, Direct2D and hosted
windows: `FullControlTest /D2D /Hosted`. Startup selected DarkSkin; testing
selected Win7Skin through the existing skin selector. Results distinguish broad
checks before the local animation endpoint correction from focused checks of
the corrected build. The upstream hosted-window focus defect remains
unresolved, as does a separate responsive-layout failure reproduced with both
skins. This record does not claim an uninterrupted full-suite pass.

## Generation and build

- GacBuild completed XML/resource generation for both x32 and x64, including
  regeneration after the animation endpoint correction.
- Both the initial and corrected `Debug|x64` builds completed with zero
  warnings and zero errors. The corrected build took 17.89 seconds.
- After XML whitespace cleanup, regeneration produced SHA-256
  identical results for all six generated C++ source/header files. The cleanup
  did not change the generated implementation exercised by that binary. This
  hash identity does not cover the subsequent animation endpoint correction.
- Static source checks found 78 unique instance classes and no color literals
  outside the central `Win7Skin.xml` palette.

Generation for x32 is not a claim of a Win32 application build or runtime test.
Build instructions are in [FullControlTest.md](FullControlTest.md).

## Completed checks before the endpoint correction

| Check | Observed result |
| --- | --- |
| Document-editor SOP | Ribbon and Toolstrip editors passed through both automation-service IO and Windows UI Automation (UIA). Covered editing, formatting, context menus, font/color dialogs, hyperlinks, images, cancellation, undo/redo and persistence, including private-format reload and RTF/HTML exports. |
| Style-gallery suite | 1,319 assertions passed: all eight styles at window widths 1,400, 650 and 1,250, including inline/popup presentations and refresh against DarkSkin. |
| Showcase walk | 2,601 assertions passed. |
| Lists | 228 assertions passed. |
| Bindable data grid | 59 assertions passed, including text, selection and date editors. |
| Text controls in a fresh process | 217 assertions passed, with Text run before grid popup lifecycle checks. |
| Refresh List in a fresh process | 46 assertions passed. |
| Calendar in a fresh process | 41 assertions passed. |
| Inline Win7 style gallery through UIA SelectionItem | 192 assertions passed, covering all eight styles. |
| Raw Clock | 128 assertions passed for UIA names, page selection and resize. |
| Resumed synthetic touch checks | 1,061 assertions passed: remaining horizontal momentum/deletion checks, multiline and single-line document touch across Win7Skin/DarkSkin refresh, and Touching UIA resize. |
| Point-input regression | 2,528 assertions passed across both editors and Win7Skin/DarkSkin, covering all target positions with forward and reversed selections. |
| Remaining responsive-modal checks | 877 assertions passed for other responsive widths, account scrolling/selection, menu behavior and OK/Cancel/title-bar closure. The compact row-height failure remains separately recorded below. |
| Immediate scroll/split-arrow presentation | Generic scroll-view colors, transparent split-arrow face, immediate two-pixel bevel and popup opening/dismissal passed. |
| Window Manager | Exact shortcut captions, the Ctrl+Q dialog and dismissal, and 50 service mouse-event/modifier combinations passed, including theme font/color checks. |

The full editor/gallery run used process 12340. It exited normally with code 0
and no CRT leak report. The later walk/list/grid checks used process
10296. The isolated text/refresh/calendar/inline-gallery checks used process
24924, which also closed normally through `Window.Close` with exit code 0 and
no CRT leak report. These observations concern CRT heap diagnostics. During
process 24924, Direct2D debug output reported allocation-count warnings for
1,001 and then 2,001 unreleased interfaces.

## Corrected-build checks

Process 23496 exercised the rebuilt animation completion helper:

| Check | Observed result |
| --- | --- |
| Startup selector | DarkSkin selected and Win7Skin unselected by default. |
| Pushbutton endpoints | Exact four-stop palette colors reached in normal, hovered, pressed and released states. |
| Animation families | Selected radio, group caption and editor colors reached their exact endpoints, including disabled/restored states; radio hover/press and editor hover/focus also passed. |
| Interrupted transitions | Button and editor transitions retained the newest requested state after 250 milliseconds. |
| Other animation consumers | Toolbar, ribbon and scrollbar-thumb normal/hover/restored colors passed. A popup dismissed 30 milliseconds into hover remained closed and the application responsive after 250 milliseconds. |
| Repeated showcase walk | 2,599 assertions passed across all pages. |
| Shared text payload | 34 assertions passed for exact `Hello[Ab]{Cd}` text through service typing, verified through UIA ValuePattern. |
| Additional mouse payloads | 50 service events passed: movement, five button double-click types and four wheel directions across five modifier combinations, complementing the earlier 50 down/up events. |

Evidence is in the `corrected-*.log` files under the local evidence directory
below, including `corrected-animation-endpoints.log`,
`corrected-animation-consumers.log`, `corrected-Walk.log` and
`corrected-SharedPayload.log`.

Process 23496 closed normally through the application's Exit action with code
0 and no CRT leak report. Direct2D emitted a runtime allocation-count warning
for 1,001 unreleased interfaces; the CRT result is not an interface-lifetime
verification.

## Scrollbar geometry followup

A later source audit verified that the historical
[GacUI/Source/Controls/Styles/GuiCommonStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/04743022c4e7e3e441cb67ac9177891c8f7cdf9f/Source/Controls/Styles/GuiCommonStyles.cpp)
uses `defaultSize` for arrow length, minimum thumb size and track-end insets;
its `arrowSize` parameter is unused. The Win7 horizontal and vertical templates
were aligned to the actual 18-pixel geometry. They were regenerated for x32 and
x64 and included in the combined Win7/Win8 `Debug|x64` build, which completed
with zero warnings and zero errors in 36.41 seconds.

Process 4044 checked Win7Skin before switching to Win8Skin. Scrollbars on
`Layout / Repeat` had 18-pixel arrows and end insets. Both populated TextList
scrollbars had 18-pixel widths, arrows and insets, with 468-pixel thumbs in the
observed fixture. Evidence is retained in `followup-scroll-geometry.log` and
the accompanying geometry snapshots under the Win7Skin evidence directory.
The affected List suite also passed all 228 assertions in this process.

## Test adaptations and coverage limits

The temporary verification adapter required these adjustments:

- Search-field `Ctrl+A` routes to the central document. The service-input path
  used `Home`, `Shift+End`, then typing to replace the field's current value.
  See [single-line shortcut routing](../suggestions/FullControlTest/SingleLineShortcutRouting.md).
- Ordinary document-style foregrounds come from the active theme. The adapter
  obtained that baseline from the editor while retaining exact checks for
  explicitly colored styles. See [the theme-dependent document-style baseline](../suggestions/FullControlTest/DocumentStyleBaseline.md).
- After Clear/Add 5 Items, the touch-list rows fit the 720-pixel viewport. UIA
  reported no vertical scroll range, `NoScroll` and a 100 percent view size.
  The adapter asserted that state and omitted the inapplicable scroll reset,
  retaining the remaining gesture checks. See
  [touch-list scroll reset](../suggestions/FullControlTest/TouchListScrollReset.md).

The original Touching invocation completed contact-transform, cancellation,
swipe, recycling and offscreen-completion groups before stopping at the scroll
reset. It did not produce a full-scenario pass count; the 1,061 assertions above
cover the resumed segment.

Popup gallery backgrounds expose UIA Toggle controls without Invoke. UIA
located and scrolled these items, while service pointer input activated them.
Those checks are mixed UIA/service coverage, not successful UIA Invoke tests;
see [gallery activation](../suggestions/FullControlTest/GalleryItemActivation.md).
For nonactivating menus that did not dismiss through synthetic Escape, the
adapter clicked outside the menu and verified dismissal.

Initial native captures of the Win7 list and ribbon were visually inspected.
Later `PrintWindow` captures were stale or blank, and native foreground input
was unavailable in the environment. The resize checks therefore establish
control structure, bounds and behavior, without a reliable post-resize pixel
comparison. No physical mouse, keyboard or touch coverage is claimed.
The Windows-key chord's caption was checked, but the automation key parser has
no Windows-key name. `Ctrl+Alt+Win+Q` activation and the native global-hotkey
route were therefore not verified.

## Animation endpoint correction

Settled-color checks found that the imported finite-animation callback omits
the duration endpoint, leaving some colors between their starting and target
values even after ten seconds. Win7Skin now wraps its XML animations in a
completion coroutine whose callback applies `Interpolate(1.0)` after normal
completion.
Cancelled wrappers do not apply their old targets. The implementation and
upstream proposal are documented in
[FiniteAnimationEndpoint.md](../suggestions/GacUI/FiniteAnimationEndpoint.md).
This source change is separate from the earlier whitespace-only regeneration.

## Shared responsive-layout failure

The responsive modal's shrink check failed with both Win7Skin and DarkSkin.
At 240 x 320 the title-only movie rows initially measured 26 pixels high;
widening to 680 x 320 added images/authors and expanded rows to 106 pixels.
Returning to 240 x 320 hid those details, but retained the 106-pixel rows,
showing three titles instead of the initial nine. The behavior is recorded in
`ResponsiveWindow.log`, `ResponsiveWindow-DarkSkin-comparison.log` and
`responsive-shrink-failure.json`; it is not counted as a passing resize check.
The source-based explanation and proposed regression are in
[ResponsiveListRowHeight.md](../suggestions/GacUI/ResponsiveListRowHeight.md).

## Upstream focus failure

Process 10296 stopped during the Text UIA `ValuePattern.SetValue` check after
the grid popup lifecycle tests. UIA returned `ElementNotAvailable`; the debugger
showed `GuiHostedController::GotFocus` following a freed `lastFocusedWindow`
through `Activate` and `BringToFront`.

`DestroyNativeWindow` clears `enteringWindow` where it should clear
`lastFocusedWindow`. The source location, stack and proposed regression are in
[HostedWindowLastFocusedWindow.md](../suggestions/GacUI/HostedWindowLastFocusedWindow.md).
The crashed process was terminated after diagnosis. Running Text first in a
fresh process isolated the remaining checks; it did not repair the defect.
No upstream or imported code was changed for this issue.

Local evidence was retained under `%TEMP%/xgskins-verification/Win7Skin`,
including the editor/style logs, `Walk.log`, `List.log`, `Grid.log`, the focused
suite logs and `Text-upstream-focus-failure.log`. Build, generation, hash and
debugger records use the `%TEMP%/xgskins-win7-*` prefix. These machine-local
artifacts are not committed build products.
