# WinXPSkin verification record

Verification began on 2026-11-18 on Windows. The required application target is
`Debug|x64`, running `FullControlTest /D2D /Hosted`. This record separates
completed source checks from generation, build and runtime results. The first
runtime build passed generation and compilation, and its point-input suite
passed. A subsequent progress-layout check crashed. The correction has passed
generation, compilation and its progress regression. Broad control, document
and layout coverage has completed across preserved invocations, with failures
and limitations recorded below. A later Raw Clock refresh triggered termination
after an automation HTTP response-send error. Required showcase coverage is
complete across preserved runs, including a fresh final process, with the
documented failures and unavailable checks retained. The final process exited
through the application with code 0, no second-chance report and no CRT leak
dump; a Direct2D live-interface warning remains recorded. No uninterrupted
full-showcase pass is claimed.

## Baseline and generation

Before implementation, `import.ps1` and `syncProj.ps1` completed without changes
to the imported or synchronized files. The baseline `Debug|x64` application
build completed with zero warnings and zero errors. Its evidence is in
`%TEMP%/xgskins-winxp-import.log`, `%TEMP%/xgskins-winxp-sync.log` and
`%TEMP%/xgskins-winxp-baseline-build.log`. This baseline build predates the new
skin and is not its build result.

The first WinXPSkin generation passed Workflow semantic compilation for x32
and x64, then failed while merging the generated C++ progress subscription.
The explicit fixed-width cast was removed on x86 and retained on x64, producing
an expression difference the merger could not accept. The original generation
log is `%TEMP%/xgskins-winxp-gacbuild.log`.

Converting the range endpoints through `double` allowed the generated files to
merge, but the application build exposed a second upstream issue:
`RangeEnumerator<T>::Index()` returns `T`, while its interface requires native
`vint`. A fixed-width `Int32` range therefore failed to compile on x64. The
failed build is retained in `%TEMP%/xgskins-winxp-range-build-failure.log`.

The integer-range workaround uses a native-integer range and a small
`ItemTemplate-eval` factory that ignores its ordinal argument and constructs a
parameterless `ProgressChunkTemplate`. The chunk count, spacing, gradients and composition
layout remain in XML. The upstream limitations, including the boxed object
constructor-parameter shorthand, and proposed fixes are documented in
[Workflow cast merging](../suggestions/Workflow/GeneratedIntegerCastMerge.md),
[the Vlpp range enumerator](../suggestions/Vlpp/RangeEnumeratorIndex.md) and
[GacUI boxed item-template parameters](../suggestions/GacUI/BoxedItemTemplateParameter.md).
No upstream or generated C++ source was manually changed for this workaround.

Resource generation for the first runtime build completed for x32 and x64, and
the generated C++ files merged successfully. The `Debug|x64` application then
built with zero warnings and zero errors in 19.75 seconds. Evidence is in
`%TEMP%/xgskins-winxp-gacbuild-final.log` and
`%TEMP%/xgskins-winxp-build.log`; the build result was checked against the
upstream build wrapper's actual `Build.log`. x32 resource generation does not
establish a Win32 application build or runtime test.

After the tracker fixture correction described below, synchronization completed
x32/x64 generation and the C++ merge successfully. The copied `RepeatTabPage.xml`
and generated `FullControlTestPartialClasses.cpp` each changed only the two
tracker dimensions from 20 to 21. No additional WinXPSkin XML or generated-skin
change was needed. The resulting `Debug|x64` build passed with zero warnings
and zero errors in 16.51 seconds, verified against the wrapper's actual
`Build.log`. Evidence is `%TEMP%/xgskins-winxp-tracker-sync.log` and
`%TEMP%/xgskins-winxp-tracker-build.log`.

## Static source checks

- All 13 XML resource files parsed successfully.
- All 80 instance classes are mapped exactly once to affected FullControlTest
  pages in [TestGuidance.md](../spec/WinXPSkin/TestGuidance.md).
- All 59 theme slots match the DarkSkin registration set, without missing or
  extra slots.
- All 153 color-package fields are used and documented exactly once in
  [ColorPackage.md](../spec/WinXPSkin/ColorPackage.md). No undefined palette
  references or color literals outside `WinXPSkin.xml` were found.
- No Win8 namespace leftovers or skin color-animation resources were found.
  Immediate state feedback is the documented reconstruction policy.
- The integration source contains one WinXPSkin selector item and preserves
  DarkSkin as the startup selection. No startup skin argument was added.
- Local documentation links and whitespace checks passed.

The audit and current palette export are in
`%TEMP%/xgskins-winxp-research/final-static-audit.json` and
`%TEMP%/xgskins-winxp-research/final-default-palette.json`. These checks establish
source consistency, not the pixels presented by a running application.

Research provenance and reconstruction choices are documented in
[WinXPSkin.md](WinXPSkin.md). Published Microsoft guide colors, WPF reference
brushes, compressed-image caption samples and invented ribbon designs are
distinguished there; the palette is not claimed to reproduce every native XP
bitmap pixel exactly. The list/calendar selected-foreground limitation and
safe palette workaround are documented in
[selected list-item text](../suggestions/GacUI/SelectedItemForeground.md) and
[selected calendar-day text](../suggestions/GacUI/SelectedCalendarDayForeground.md).

## Runtime checks

Process 4572 launched under CDB at 07:49 PST, with debugger output in
`%TEMP%/xgskins-winxp-debugger.log`. The startup and point-input results below
precede its progress-layout crash. Corrected process 27980 launched under CDB
at 08:12 PST, with debugger output in
`%TEMP%/xgskins-winxp-progress-debugger.log`. Its progress regression and broad
control/document/layout checks preceded the Raw Clock runtime-error condition.

Fresh process 25932 launched under CDB at 11:18:12 PST with the rebuilt fixture
and the same `/D2D /Hosted` arguments. Its debugger log is
`%TEMP%/xgskins-winxp-final-debugger.log`. It completed the rebuilt tracker and
remaining coverage recorded below. Its startup again confirmed four selectors
with DarkSkin selected by default.

| Check | Status |
| --- | --- |
| DarkSkin startup and selector | Confirmed four entries: DarkSkin selected; Win7Skin, Win8Skin and WinXPSkin unselected. |
| Theme-state preservation across all four skins | Maximum progress survived six replacements. Mixed docking and table text/geometry survived all four skins across preserved continuations. Both document editors retained text/selection across XP/Dark refresh; their strict saved-byte checks failed as recorded below. |
| Fresh point-input regression | 2,479 assertions passed, including all 48 forward/reversed caret comparisons and long-press popup parity across WinXPSkin/DarkSkin and Ribbon/Toolstrip editors. |
| Button, checkbox and radio states | Command/radio/check normal, hover, pressed, selected and disabled palettes passed where applicable; the command button's blue keyboard-focus rim passed. Radio artwork measured 13 pixels and the selected checkbox used a nine-pixel XML check polygon. |
| Editor and group states | XpConsumers passed 42 assertions. Independent flags plus saved paint confirmed focused white editor faces, disabled beige-gray faces, blue-gray borders and the disabled Operations caption. Source review and UIA foreground 0 confirm that plain disabled document text retains black; the missing gray foreground override is a documented fidelity limitation. |
| Active caption composition | A saved settled XP snapshot contained the expected blue body and blue/red button gradients. Caption faces measured 21 x 22 pixels in this run, satisfying the 21-pixel minimum while allowing title-font-driven row growth. |
| Disabled caption composition | The modal-disabled owner used the inactive blue caption body and muted blue faces for all three caption buttons, including Close, matching the recorded disabled state. |
| Checked image-menu paint | The saved Editable row had a visible image well with `#E1E6E8` fill and `#316AC5` outline. This establishes the selected-paint appearance; provider Toggle/Selection state was not independently asserted. |
| Enabled inactive caption | The corrected enabled-child check passed 21 assertions, confirming inactive blue body and muted-red Close paint after activating the main caption. The original owner-inactive predicate remains a fixture expectation failure because an active owned child keeps its owner rendered active. |
| Scrollbar, tracker and segmented-progress geometry and values | Process 27980 passed zero/middle/full progress at 0/5/10, six-pixel chunks/two-pixel gaps, and 17-pixel scroll arrows with four light/four shadow grip stripes. Its 20-pixel tracker fixture clipped the final pixel. After the fixture correction, process 25932 completed all four skins' 21-pixel cells, unclipped handles, both tracker drags and range retention; XP's 11 x 21 / 21 x 11 bounds and queued middle/full chunk counts passed. The original crash and refresh/provider interruptions remain recorded. |
| Progress resize and replacement | Passed at window widths 1,000, 1,400, 900 and 1,200, followed by six skin replacements retaining the maximum value and recreating XP chunks. |
| Scrollbar and tracker interaction | Both scrollbar axes passed forward/opposite arrow changes and thumb dragging. A corrected targeted continuation passed dragging both tracker axes through application service input. |
| SOP basic fixtures | 91 assertions passed: paired text lists followed the exact empty-to-0..9-to-empty sequence, and distinct Ribbon Search/document markers survived a List-to-Control round trip. |
| Text, lists, refresh lists, trees and calendar | List passed 233 assertions, Text 214, Calendar 39 and Refresh 46. Calendar desktop-focus lookup was unavailable in the disconnected session. The separate final grid result is recorded below. |
| Document-editor context menus | Four initial combinations passed: Ribbon/Toolstrip with WinXPSkin service input, then Ribbon/Toolstrip with DarkSkin UIA after refresh. A separate target-XP UIA-context supplement passed 369 assertions for both editors. Menu opening and the recorded Escape fallback still used service input. |
| Document-editor service commands | Both editors completed their service-command coverage across preserved runs. |
| Ribbon UIA commands | Clipboard, formatting/color dialogs, persistence, all hyperlink/image routes, modes and sample fields passed across continuations, except that direct-font exact-family comparison and call completion remain unverified. |
| Toolstrip UIA commands | Editing, formatting/dialog outcomes, persistence, all hyperlink/image routes, modes, persistence cancellation and point-scroll/long-press behavior passed. Direct Text Color's subsequent idle wait was unavailable despite its verified semantic outcome. |
| Style galleries | The XP pass completed eight inline styles, all eight popup choices at widths 1,400/650/1,250, six samples and private reload checks. The resumed DarkSkin UIA pass completed the corresponding coverage with 673 assertions. A separate target-XP inline UIA pass completed 194 assertions. Both resumed passes recorded zero unavailable dialog completions; the refresh interruption remains recorded. |
| Document exchange | Both editors failed strict saved-byte equality. Toolstrip's initial undo wait also timed out; a no-replay followup verified exact original text, then saved the same 117,679-byte representation as Ribbon. Text equality does not establish full formatting/model equivalence. |
| Easy Layout docking and tables | Combined coverage completed across all four skins. The final XP table continuation passed 194 assertions; two earlier provider-read failures remain recorded. |
| Responsive layout and window | Ribbon resize and responsive-level checks passed across continuations. The strict compact-row shrink assertion failed at 26 to 106 to 106 pixels. An additive continuation passed 877 remaining assertions without changing that original failure. |
| Raw Clock | Fresh process 25932 passed 160 assertions using bounded 60-second requests and explicit palette readiness. The original process 27980 response-send exception and termination remain failed; the fresh pass does not prove the failure's cause or a fix. |
| Full page walk | Passed 3,201 assertions across the showcase pages, with 172 structure and 168 property events and zero unavailable dialog completions. This coverage includes page discovery, not normal application Exit. |
| Final grid checks | The resumed body passed 59 assertions, with 29 structure, 19 property and one text event. The initial root-provider readiness timeout occurred before the body and remains failed. No trailing palette change was made. |
| Synthetic touch checks | Raw transforms/cancellation/fallback, ordinary ListView, full TouchingList, XP/Dark multiline/single-line and final UIA resize/leave-return checks completed across preserved invocations. The final Dark continuation passed 157 assertions. Provider/idle/fixture failures remain recorded; physical touch remains unverified. |
| Shared input payload | A narrow continuation passed 32 assertions, including the exact typed value `Hello[Ab]{Cd}`. The original pre-input false idle assertion remains failed; physical keyboard input is not claimed. |
| Window Manager, shortcut and mouse payloads | Service captions/Ctrl+Q and two 50-case mouse matrices passed. Native five-button down/up and local Ctrl+Alt+Win+Q passed. The global Ctrl+Shift+Alt+Win+Q ten-second wait failed; a later fresh query verified its exact callback dialog without replay, then dismissed it once. |
| Native injected pointer/mouse input | Passed native single/multiple/cancelled WM_POINTER contacts, rejected-touch OS mouse fallback, independent unpromoted mouse, and TouchingList outside-window drag/virtualization/fresh-touch checks. The owned window was already foreground; no activation was performed. This is injected input, not physical hardware or native pixel verification. |
| Window scenario | Native move/resize, menu/formatting, modal/subwindow lifecycle and the final settled palette state completed across separate invocations. The palette-only finish passed 12 assertions; the earlier fixture-clear and post-refresh lookup failures remain recorded. |
| Application automation and available Windows UI Automation | Required coverage completed across the recorded invocations. Provider, idle, serialization and responsive failures remain explicit; this is not an uninterrupted full-suite pass. |
| Exit through the application, debugger result and leak diagnostics | Final process 25932 exited through the actual Exit page's queued `self.Close()` command with code 0. Its completed CDB log contains no second-chance report or CRT leak dump, but retains one Direct2D 1,001-live-interface warning. Earlier processes 4572 and 27980 remain failed runs. |

Point-input evidence is in `%TEMP%/xgskins-winxp-point.log`. The adapter reports
the Windows session as `WTSDisconnected`, so desktop-focus lookup remained
unverified. Its service-input, caret and popup assertions do not establish
physical mouse/keyboard input or a connected-desktop focus check.

Button-state evidence is in `%TEMP%/xgskins-winxp-buttons.log`. Two earlier
adapter invocations stopped while dismissing a localized shortcut modal; their
logs remain in `%TEMP%/xgskins-winxp-buttons-modal-fixture.log` and
`%TEMP%/xgskins-winxp-buttons-modal-wait.log`. An opening snapshot showed a
240 x 120 dialog whose button row occupied y=492..516 while its parent clip
ended at y=492. After an idle gap, the dialog grew to 240 x 144 and contained
one visible `确定` button.

The adapter's 50-millisecond polling gap, combined with full Controls exports
taking about 700 milliseconds, appeared to delay the autosize. That timing
explanation is an inference, not a proven skin or framework defect. A bounded
30-second wait with 500-millisecond idle gaps then found the same visible
button and completed all endpoint checks. The adapter retained the
visible-button requirement and changed no skin source. The transition snapshot
is `%TEMP%/xgskins-winxp-modal-opening.json`.

Scrollbar interaction evidence is in
`%TEMP%/xgskins-winxp-scroll-interaction.log`. That invocation passed both
scrollbar axes, then stopped because the horizontal tracker was already at
the endpoint toward which the fixture tried to drag it. The first targeted
continuation also stopped: its comparison omitted the snapshot's `.bounds`
projection, although the tracker had moved. That failure remains in
`%TEMP%/xgskins-winxp-tracker-predicate-fixture.log`. Correcting the destination
selection and bounds lookup, without changing skin source, produced the
passing horizontal and vertical tracker continuation in
`%TEMP%/xgskins-winxp-tracker-continuation.log`. These are combined recorded
invocations, not one uninterrupted interaction-suite pass.

For this verification, the sync script enlarged the horizontal tracker's row
and the vertical tracker's column from 20 to 21 pixels. The current showcase
uses the upstream 20-pixel cells. The historical workaround and upstream
proposal are in
[TrackerFixtureSize.md](../suggestions/FullControlTest/TrackerFixtureSize.md).
That correction passed synchronization, both generation architectures, the
generated-code merge and the rebuilt application as recorded above. Runtime
geometry, ancestor clipping and interaction checks completed across the preserved
invocations below. The correction does
not retroactively change the dimensions observed in process 27980.

In fresh process 25932, the first rebuilt Repeat pass verified DarkSkin's
21-pixel tracker cells, unclipped handles, both tracker drags, and middle/full
progress values. The subsequent service switch to Win7Skin left zero-sized
caption bounds and tab bounds `(5,5)-(5,5)` in the saved snapshot, and waiting
ten seconds for Layout timed out. No native runtime-error window was found.
A one-pixel UIA resize followed by restoration recovered 26 visible text
elements. The cause of the blank refresh has not been established; this is
not identified as a tracker-source defect.

The original failed invocation remains in
`%TEMP%/xgskins-winxp-final-repeat.log`, with snapshots
`%TEMP%/xgskins-winxp-final-repeat-refresh-timeout.json` and
`%TEMP%/xgskins-winxp-final-repeat-refresh-after-resize.json`. The remaining
Win7Skin/Win8Skin/WinXPSkin checks continue separately in
`%TEMP%/xgskins-winxp-final-repeat-resume.log`, using the existing
`PersistencePalette` helper's provider-retirement, fresh-root readiness and
resize sequence. Win7Skin and Win8Skin completed their checks in that resumed
run. The subsequent XP palette helper threw `ElementNotAvailableException`
at an unidentified internal stage. A fresh inspection independently confirmed
XP selected, horizontal value 10, vertical value 5 and read-only progress 10,
without replaying the palette action. The provider-failure snapshot is
`%TEMP%/xgskins-winxp-final-repeat-xp-provider-failure.json`.

The final XP-only continuation in `%TEMP%/xgskins-winxp-final-repeat-xp.log`
completed its geometry, drag, retained-range and progress checks. Together,
the three invocations verify 21-pixel tracker cells and handles within their
ancestor clips for all four skins, plus both-axis drags. XP's handles measure
11 by 21 and 21 by 11, read-only progress follows the horizontal tracker, and
the queued intermediate/full six-pixel chunks with two-pixel gaps settle to the
expected count. Successful saved states are
`%TEMP%/xgskins-verification/WinXPSkin/xp-final-repeat-{skin}.json` and their
`-Middle`/`-Maximum` variants. These are composition/interaction results, not
native pixel verification. Both the original blank-refresh timeout and the
later provider failure remain recorded; neither becomes a successful original
invocation. The readiness limitation and source investigation proposal are in
[ThemeRefreshLayoutReadiness.md](../suggestions/GacUI/ThemeRefreshLayoutReadiness.md).

The basic SOP result is recorded in `%TEMP%/xgskins-winxp-SopBasics.log` and its
artifact directory under `%TEMP%/xgskins-verification/WinXPSkin`. The deeper
document-editor SOP is separate; its interruption and resume are recorded below.

Offline review of `xp-progress-after-resize-and-theme-replacement.json` under
that verification directory confirmed the active caption body's
`#0154E2` to `#0061FA` gradient and the normal close face's `#E97C5F` to
`#E55B2C` gradient. The two blue caption faces used `#638DF9` to `#3278F4`.
These are composition-paint observations consistent with the documented
reconstruction palette. They do not establish native pixels or independently
exercise inactive, disabled, hovered or pressed caption transitions.

`XpConsumers` passed 42 assertions with independent UIA enabled/focused/owner
flags and saved composition snapshots. Focused enabled editors used white
faces and `#7F9DB9` borders; modal-disabled editors used `#EBEBE4` faces with
the same border. The disabled Operations group used `#A1A192` caption text and
`#D0D0BF` border. UIA ForegroundColor returned 0 for both enabled and disabled
editor text. Source review confirms that default-colored disabled document
text retains the black baseline. The template has no disabled foreground paint
property, its baseline is consumed at installation, and the renderer uses the
resolved model/run colors. The original run recorded composition and UIA data.
A later hosted run captured the same field with its owner enabled and disabled.
Explicit author styles remain intact. Recoloring through the template would
require mutating or reinstalling the document state. The screenshots and
proposed renderer property are in
[DisabledDocumentForeground.md](../suggestions/GacUI/DisabledDocumentForeground.md).

The disabled owner caption had `#7A96DF` to `#7FA0E7` body paint and
`#A6BCEB` to `#7C9CDF` faces for minimize, maximize and Close. These saved values
agree with the documented disabled-caption reconstruction; they are not
native-pixel evidence. The log is `%TEMP%/xgskins-winxp-XpConsumers.log`.
Snapshots, flag files and `xp-consumers-paint-audit.json` are in
`XpConsumers-20261118-183009-527` under the verification directory.

The separate `XpWindowPaint` snapshot showed the enabled Editable menu row's
visible selected-image well with `#E1E6E8` fill and `#316AC5` outline. Its saved
flags establish enabled/focused/owner-enabled state, not independent provider
Toggle or Selection state. The paint branch itself is the observed evidence.
Files are `xp-menu-checked-image.json` and `xp-menu-checked-image-flags.json`
under `XpWindowPaint-20261118-183428-870` in the verification directory.

That scenario then timed out waiting for an enabled owner's inactive caption
and muted-red Close after opening a nonmodal child. Both owner and child
continued to show active caption paint, even after one service click on the
child caption. Native activation was not attempted. The failed wait remains
in `%TEMP%/xgskins-winxp-XpWindowPaint.log`; both saved observations are
`%TEMP%/xgskins-winxp-inactive-paint-timeout.json` and
`%TEMP%/xgskins-winxp-inactive-after-child-click.json`.

Source review identifies the original predicate as a fixture expectation
error. The window template's Activated value follows rendering activation in
[GacUI/Source/Application/Controls/GuiWindowControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/Controls/GuiWindowControls.cpp).
The hosted manager intentionally keeps the common owner chain rendered active
in
[GacUI/Source/PlatformProviders/Hosted/GuiHostedWindowManager.h](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Hosted/GuiHostedWindowManager.h).
FullControlTest's `ShowWithOwner(self)` creates that relationship in
[GacUI/Test/Resources/App/FullControlTest/Resource.xml](https://github.com/vczh-libraries/GacUI/blob/master/Test/Resources/App/FullControlTest/Resource.xml).
An active owned child therefore does not require an inactive owner caption.
The corrected check clicked the exposed main caption through service input and
inspected the still-enabled child, whose inactive appearance uses the same XP
template. It passed 21 assertions. Independent child flags reported enabled
true, focused false and owner enabled true; saved paint showed body
`#7A96DF` to `#7FA0E7` and Close `#AE728C` to `#B2798A`. Offline review confirmed
those exact gradients. Only the child was then closed normally.

The corrected log is `%TEMP%/xgskins-winxp-XpInactiveChild.log`; the saved
`xp-caption-inactive-child.json` and matching flags are under
`XpInactiveChild-20261118-184040-030` in the verification directory. This is
composition/state evidence, with native pixels still unavailable. The original
predicate failure is retained as a fixture misunderstanding, not a skin paint
defect.

## Document-editor SOP interruption

The initial invocation completed all four context-menu combinations described
above. UIA has no point-injection or context-menu-open pattern, so menu opening
used service input; the context checks retained their synthetic Escape/outside
click dismissal fallback. The DarkSkin refresh in the UIA phase means these
results do not establish WinXPSkin UIA-context coverage.

A later `ThemeContextUia` supplement specifically selected WinXPSkin for both
Ribbon and Toolstrip and passed 369 assertions. Commands used UIA; menu opening
used service input, and the synthetic Escape/outside-click fallback remained
recorded. Evidence is `%TEMP%/xgskins-winxp-ThemeContextUia.log`, with artifacts
in `DocumentContextMenu-20261118-183705-732` under the verification directory.
This supplies the target-XP UIA-context coverage separately from the original
DarkSkin UIA phase.

The following Ribbon service-input command groups completed before the stop:
all three clipboard routes, Bold/Italic/Underline/Strike on/off, paragraph
alignment, and context-menu font, text-color and background-color dialog
cancellation/application. The next repeated Set Font dialog timed out waiting
for another visible font family. This was an adapter wait failure; it is not
an uninterrupted document-editor SOP pass.

The timeout snapshot showed only the selected family and one size row. After
polling stopped, the same outer dialog exposed eight family rows and
nine size rows, without changing its outer bounds. The effect of frequent
polling on layout is an inference, not a confirmed source defect. The adapter
changed only the visible-family predicate's idle gap from 30 to 500 milliseconds,
retained the 60-second bound and actual visible-choice requirement, dismissed
the unfinished dialog, and resumed `DocumentEditorCommands` at `StartStep = 1`
with a fresh output directory. No skin source changed for this adjustment.

The original failure is retained in `%TEMP%/xgskins-winxp-DocumentEditorSop.log`
and `DocumentEditorSop-20261118-163108-486/uia-timeout.json` under the WinXPSkin
verification directory. The later state is
`%TEMP%/xgskins-winxp-font-family-failure.json`. The resumed log is
`%TEMP%/xgskins-winxp-DocumentEditorCommands-step1.log`, with artifacts in
`DocumentEditorCommands-20261118-164546-317` under that directory.

The first resumed invocation passed the previously failing font-family choice,
including the exact changed family and 22-pixel size. It completed the Ribbon
service-input formatting/dialog checks, private-format save/reload and RTF/HTML
exports; all three hyperlink routes; and context-menu image cancellation,
insertion, undo/redo, private-format persistence and RTF/HTML export checks.
It then stopped with `ElementNotAvailableException` in `EditorSelect`, after
reloading the fixture and before the direct-image route. The application
remained responsive, the expected fixture was loaded and no modal was open.
The precise provider/range invalidation cause is not yet established.

That exception remains in the step-1 resume log; the later responsive state is
saved in `%TEMP%/xgskins-winxp-image-provider-failure.json`. A fresh-provider
continuation resumes at `StartStep = 2` with `ResumeAtImages` and an adapter
switch restricting the resumed image group to the unfinished direct route.
It adds stage diagnostics, without automatic retries, source changes or
repeating completed groups. Its log is
`%TEMP%/xgskins-winxp-DocumentEditorCommands-step2-direct.log`, with artifacts in
`DocumentEditorCommands-20261118-165627-738` under the verification directory;
it completed the Ribbon direct-image route, modes/shortcuts/persistence
cancellation, Search/Icon Labels fields and Alignment group action. It then
completed the Toolstrip service-input clipboard routes, formatting and dialog
checks, private-format persistence and RTF/HTML exports, all three hyperlink
routes, and both image routes with their exact undo/redo and persistence
assertions.

After the last image export and fixture reload, this continuation stopped
before Toolstrip mode input. Its added stage diagnostics isolate the new
`ElementNotAvailableException` to `document.SetFocus()`, before any text-range
comparison in `EditorSelect`. No CDB fatal exception or new skin source failure
was established. The cause is still being investigated; this stage result is
not evidence that the earlier exception had the same trigger, nor that the
previously documented hosted-window focus-lifetime defect caused either one.

A fresh provider probe found the expected fixture in a visible, enabled and
focused GacUI document in process 27980. Its RuntimeId was
`42,7013042,4,26752`, with document HWND 0 under root HWND 7013042; the earlier
provider's RuntimeId was unavailable. The probe therefore confirms a usable
current provider, without proving that the earlier provider had been retired
or establishing why `SetFocus()` failed. Evidence is in
`%TEMP%/xgskins-winxp-provider-probe.log`.

The `StartStep = 7` fresh-provider continuation passed Toolstrip modes,
shortcuts, cancelled persistence, synthetic point scrolling, long-press
release behavior and selection-preserving menu dismissal. The menu required
the recorded outside-click fallback when synthetic Escape did not dismiss it.
This completes the service-command coverage for both editors across the
preserved invocations. It then passed all three Ribbon UIA clipboard routes,
Bold/Italic/Underline/Strike toggles, alignment and the context-menu font,
text-color and background-color cancel/apply checks.
The continuation log is `%TEMP%/xgskins-winxp-DocumentEditorCommands-step7.log`,
with artifacts in `DocumentEditorCommands-20261118-171230-143` under the
verification directory. It stopped with `ElementNotAvailableException` in
`EditorDialogAction` during the subsequent direct Ribbon Set Font apply action.
The log records the action attempt but does not contain the helper's completed
post-apply assertions. Process 27980 remained responsive and CDB reported no
second-chance exception.

A fresh provider probe independently observed selection `P`, family
`@DengXian` and size 19.5 points, equivalent to the requested 26 pixels. This
verifies the requested size after the action. The local requested-family value
was not logged before the exception, so the exact-family comparison cannot be
reconstructed from the retained evidence. Successful UIA call completion and
the failing internal stage of `EditorDialogAction` also remain unverified.
The probe is `%TEMP%/xgskins-winxp-font-close-provider.log`, and the saved
responsive state is `%TEMP%/xgskins-winxp-uia-font-close-failure.json`.

The `StartStep = 9` continuation with `ResumeDirectColors` preserved and
verified the observed `P` / `@DengXian` / 19.5-point checkpoint without reloading
the fixture. It passed the remaining direct UIA text/background color
cancel/apply checks, formatting private-format persistence and RTF/HTML
exports, all three Ribbon UIA hyperlink routes, both image routes, modes and
sample fields. It then passed Toolstrip UIA clipboard, all four format toggles,
all context font/color dialogs and direct font/color outcomes, formatting
persistence, all three hyperlink routes, and both context/direct image routes
with cancellation, insertion, undo/redo, private-format persistence and RTF/HTML
exports. Final Toolstrip modes, persistence cancellation, point scrolling,
long-press release behavior and selection-preserving dismissal then passed,
and the scenario reached its command-output boundary before entering the
style-gallery checks. Its log is
`%TEMP%/xgskins-winxp-DocumentEditorCommands-step9-colors.log`, with artifacts in
`DocumentEditorCommands-20261118-172717-976` under the verification directory.

The adapter now records an unavailable dialog-action completion separately and
continues only if independent inspection establishes that the dialog closed.
It never repeats the Invoke operation, and the caller still checks the exact
semantic outcome. One precisely classified unavailable completion has now
occurred in this continuation: direct Toolstrip Text Color apply. Invoke
returned normally; the exception occurred later in the root window's
`WindowPattern.WaitForInputIdle`. A fresh service inspection independently
confirmed that the modal had closed, and the caller's exact requested RGB and
selection assertions passed. The command was not replayed. This is a semantic
pass with an unavailable idle completion, not an unqualified completion pass.
The transient closure snapshot was queried but not saved; the step-9 log
retains the stage-qualified `UNVERIFIED` event followed by the semantic pass.
The direct Toolstrip Set Font action completed normally.

This later stage diagnosis does not identify the failing internal stage of the
earlier Ribbon direct-font action, establish its successful call completion, or
recover its unrecorded requested-family value. Those original limitations
remain unchanged; no final assertion count has been emitted.

Across the preserved invocations, all four editor-command combinations
(Ribbon/Toolstrip through service input/UIA) have completed their editing,
formatting, hyperlink and image paths, subject to the two explicit UIA
limitations above. This combined coverage does not erase the interrupted
invocations or establish an uninterrupted full-SOP pass.

The provider interruptions remain failed test invocations, without
attributing an unconfirmed defect to the skin. Original and resumed evidence
must be interpreted together; no uninterrupted full-SOP result is claimed.

## Style-gallery refresh interruption

The step-9 continuation passed all eight inline XP styles through service
pointer input, all eight popup styles at each of widths 1,400, 650 and 1,250,
and six sample entries. Catalog and styled-document private-format save/reload
checks also completed. Popup backgrounds do not expose UIA Invoke: UIA
discovery/scrolling plus service-pointer activation is mixed coverage, as
described in
[GalleryItemActivation.md](../suggestions/FullControlTest/GalleryItemActivation.md).

Immediately after the styled-document reload and refresh to DarkSkin, the
adapter threw `ArgumentOutOfRangeException` in `DocumentStyles`, before loading
the second pass's fixture. Its baseline lookup indexed `Find(Edit)[0]`
immediately after page selection. A later snapshot showed the settled DarkSkin
Ribbon with seven edit controls and the document. The original failure remains
in `%TEMP%/xgskins-winxp-DocumentEditorCommands-step9-colors.log`; the later state
is `%TEMP%/xgskins-winxp-style-refresh-failure.json`.

The adapter now waits up to 30 seconds for an actual nonpassword, onscreen edit
control with positive width and height; method entry also waits for the body
providers. It resumes only the unfinished DarkSkin UIA gallery pass, skipping
the completed XP pass and all document commands. No skin source changed. The
new log is `%TEMP%/xgskins-winxp-GalleryUiaRemaining.log`, with artifacts in
`DocumentStyles-20261118-180838-296` under the verification directory.
The resumed DarkSkin UIA pass completed with 673 assertions and zero unavailable
dialog completions. It covered all eight inline styles, all eight popup choices
at the same three widths, six sample entries through UIA Invoke, and catalog
and styled-document private reloads. The popup route retained its mixed
discovery/scrolling and service-activation limitation. The completed XP pass and
failed refresh lookup remain separate evidence; the 673 count belongs only to
this resumed pass and is not a combined uninterrupted scenario total.

The separate `ThemeGalleryUia` supplement exercised all eight inline styles
through actual WinXPSkin UIA SelectionItem providers, followed by catalog and
private reload checks. It passed 194 assertions with zero unavailable dialog
completions. Evidence is `%TEMP%/xgskins-winxp-ThemeGalleryUia.log`, with artifacts
in `DocumentStyles-20261118-184108-141`. This supplements the earlier XP service
popup/sample coverage and the resumed DarkSkin UIA pass; it does not claim
UIA Invoke support for popup backgrounds.

## Document-exchange byte mismatch

The separate `DocumentExchange` scenario verified Ribbon XP-to-Dark contents
and selection retention, then exact text restoration through undo. Its final
assertion requiring the saved private document to equal the original bytes
failed. The original was 117,713 bytes and the saved file 117,679 bytes.
Comparing their extracted XML showed a 34-byte reduction: the saved final
paragraph omitted the explicit `face="Segoe UI"` and bold-off/italic-off
wrappers while retaining its text, size and color. The 115,980-byte binary
suffix after `</Doc>` was identical, and no text or image-data change was
observed in that comparison.

This records a change in representation after load/edit/undo/save. It does not
prove complete semantic equivalence, isolate the normalization's cause, or make
the exact-byte assertion pass. The native diagnostic found no owned Microsoft
Visual C++ Runtime Library window. No skin source change was made.
The independent binary comparison, plausible paragraph-normalization/undo
path and proposed upstream checkpoints are documented in
[DocumentUndoSerialization.md](../suggestions/GacUI/DocumentUndoSerialization.md).

Evidence is `%TEMP%/xgskins-winxp-DocumentExchange.log`, with artifacts in
`DocumentExchange-20261118-181702-414` under the verification directory. The XML
comparison files are `%TEMP%/xgskins-winxp-exchange-original.xml` and
`%TEMP%/xgskins-winxp-exchange-saved.xml`. A continuation for only Toolstrip starts
in DarkSkin, loads the original fixture, types/selects `§`, changes to WinXPSkin
and checks full text, selection, exact undo text and strict byte equality. It
does not replay Ribbon. The log is
`%TEMP%/xgskins-winxp-DocumentExchangeRemaining.log`, with artifacts in
`DocumentExchange-20261118-182040-846` under the verification directory; its
undo-text wait timed out and remains a failed invocation. The saved
`uia-timeout.json` still contained `§`. Without replaying Undo, a later service
snapshot and fresh UIA provider showed the original ending with that marker
absent. Those later observations do not establish exactly when the operation
completed or why the earlier wait failed. No lost-undo or focus-routing cause
has been established.

The later evidence is `%TEMP%/xgskins-winxp-exchange-undo-failure.json` and
`%TEMP%/xgskins-winxp-exchange-undo-provider.log`. A minimal finish independently
verified the full original text, including image placeholders, without
replaying Undo or changing, reloading or refreshing the document. Its expected
and actual text files were identical at 257 bytes. It then saved the document
and failed the same strict byte comparison. The Toolstrip save was byte-for-byte
identical to Ribbon's 117,679-byte save, with the same 34-byte XML simplification
and unchanged binary suffix. The original ten-second timeout remains failed.

The finish log is `%TEMP%/xgskins-winxp-DocumentExchangeFinish.log`, with artifacts
in `DocumentExchangeFinish-20261118-182922-876` under the verification directory,
including `Exchange-27980/editor-1.bin` and the expected/actual text files.
Both strict serialization failures remain failed; the later exact text result
does not establish complete formatting equivalence.

## Window fixture and refresh continuation

The initial Window invocation passed native Transform move/resize checks, then
timed out clearing the Toolstrip fixture with Ctrl+A followed by Delete. A
fresh provider still reported the original content, focus true and no selection.
The narrow continuation selected the whole document through TextPattern,
verified that selection, sent Delete and verified an empty document. It then
completed menu/formatting, modal Invoke and asynchronous logical-subwindow
lifecycle checks. No skin source changed; the observation and targeted
verification workaround are recorded in
[clearing the Toolstrip document fixture](../suggestions/FullControlTest/ToolstripDocumentClear.md).

That continuation later stopped at the palette-replacement boundary because
the immediate lookup could not find the rebuilt Window Manager tab. A final
palette-only check waited up to 30 seconds for the actual rebuilt tab and
independently confirmed settled DarkSkin selection, without replaying the
palette action. It passed 12 assertions. The combined checks cover the Window
scenario, while both earlier failed invocations remain retained.

Evidence logs are `%TEMP%/xgskins-winxp-Window.log`,
`%TEMP%/xgskins-winxp-WindowRemaining.log` and
`%TEMP%/xgskins-winxp-WindowPaletteFinish.log`. Their artifact directories are
`Window-20261118-183104-529`, `Window-20261118-183213-630` and
`WindowPaletteFinish-20261118-183418-649` under the verification directory.
The original fixture state is retained in
`%TEMP%/xgskins-winxp-window-fixture-provider.log` and
`%TEMP%/xgskins-winxp-window-fixture-state.json`.

## Broad control coverage

The following independent scenarios completed in process 27980. Artifact
directories are beneath `%TEMP%/xgskins-verification/WinXPSkin`; logs use the
prefix `%TEMP%/xgskins-winxp-` and the scenario name followed by `.log`.

| Scenario | Completed checks | Assertions | Artifact directory |
| --- | --- | --- | --- |
| List | Paired text lists, all six ListView modes with retained providers, and TreeView hierarchy, expansion and selection. | 233; structure events 137, property events 54. | `List-20261118-184335-253` |
| Text | TextBox/Document variants with and without Tab, Value/Text patterns, range movement, selection, attributes and events. | 214; structure events 54, property events 24, text events 30. | `Text-20261118-184606-256` |
| Calendar | DatePicker selection and calendar grid/table semantics. | 39; structure events 8, property events 14. | `Calendar-20261118-184750-381` |
| Refresh | Same-count list names/cells/columns and tree-value refreshes. | 46; structure events 21, property events 28. | `Refresh-20261118-184822-179` |

All four reported zero unavailable dialog completions. Calendar separately
reported two unavailable desktop-focus lookups because the session was
`WTSDisconnected`; those checks remain unverified despite the semantic passes.
Event counts are reported observations, not extra assertions to add to the
scenario totals.

The final broad page walk subsequently passed 3,201 assertions, with 172
structure events, 168 property events and zero unavailable dialog completions.
Evidence is `%TEMP%/xgskins-winxp-final-Walk.log`, with artifacts
`Walk-20261118-194611-092`. It visited the showcase pages, including the Exit
entry, and explicitly retained the application for further verification; this
is not an application-exit result. The final grid scenario is separate.

The initial grid invocation failed before its body at
`Timed out: owned GacUI provider ready`; its log is
`%TEMP%/xgskins-winxp-final-Grid.log`, artifacts `Grid-20261118-194718-462`.
No exact runtime-error title was present and the process remained live. A fresh
read-only `FromHandle(1049892)` identified the enabled, onscreen GacUI root for
process 25932; evidence is `%TEMP%/xgskins-winxp-grid-root-provider.json` and
`%TEMP%/xgskins-winxp-grid-entry-state.json`. The previously unexecuted grid body
then passed 59 assertions, with 29 structure, 19 property and one text event,
in `%TEMP%/xgskins-winxp-final-Grid-resume.log`, artifacts
`Grid-20261118-194852-003`. The helper completed normally without replaying grid
actions or making a trailing palette change. The original entry timeout
remains a failed invocation.

## Easy Layout and responsive continuations

`EasyLayoutOnly` completed mixed docking/state retention across all four skins,
original/enlarged table splitter gestures, and a mouse-triggered rebuild. The
subsequent Invoke rebuild returned, then `RebuiltLayoutPage` threw
`ElementNotAvailableException`; the exact internal failing stage was not
established. A fresh, no-replay continuation verified the rebuilt descriptor,
`Updated` table text and geometry, then completed table palette checks for
DarkSkin, Win7Skin and Win8Skin. The final XP current-property read threw another
`ElementNotAvailableException`, without identifying the exact field. Its saved
state showed XP installed, retained `Updated` text and 120-by-40 settings at
1,470 by 1,100 window bounds.

A final no-replay XP-only continuation independently verified the remaining
text and geometry postconditions and restored 1,250 by 900. It passed 194
assertions. This completes the combined docking/table checks while preserving
both failed provider-read invocations; it is not an uninterrupted pass.

| Log after `%TEMP%/xgskins-winxp-` | Artifact directory under the verification directory |
| --- | --- |
| `EasyLayoutOnly.log` | `EasyLayoutOnly-20261118-184901-554` |
| `EasyLayoutTablePaletteResume.log` | `EasyLayoutOnly-20261118-185731-394` |
| `EasyLayoutTableFinish.log` | `EasyLayoutOnly-20261118-190235-629` |

The failure states are `%TEMP%/xgskins-winxp-table-rebuild-provider-failure.json`
and `%TEMP%/xgskins-winxp-table-palette-provider-failure.json`. The first native
diagnostic found no runtime-error window; neither provider failure establishes
a skin source defect.

`ResponsiveWindow` passed Ribbon resize regressions, then failed while reading
page `SelectionItem.IsSelected` on entry to Layout/Responsive, before its
levels and modal checks. A targeted continuation passed view/stack/group
levels, the vertical rail, control order and five-pixel spacing, Up/Down
keyboard input and ALT activation. It then failed the original strict row-height
assertion: compact rows initially measured 26 pixels, detailed rows measured
106 pixels, and compact rows retained 106 pixels after shrinking. This
reproduces the shared behavior documented in
[ResponsiveListRowHeight.md](../suggestions/GacUI/ResponsiveListRowHeight.md).

After modal cancellation, `ResponsiveRemaining` passed 877 additive assertions
for the remaining responsive appearances, account/footer behavior, selection
and OK/Cancel/title-bar closures, including three fresh 240-by-320 openings.
It explicitly printed the known failure and omitted only the failed compact-row
shrink check. No skin source or original predicate changed. The 877 count does
not convert the original row-height failure into a pass.

| Log after `%TEMP%/xgskins-winxp-` | Artifact directory under the verification directory |
| --- | --- |
| `ResponsiveWindow.log` | `ResponsiveWindow-20261118-190300-836` |
| `ResponsiveLevelsResume.log` | `ResponsiveWindow-20261118-190354-240` |
| `ResponsiveRemaining.log` | `ResponsiveWindow-20261118-190455-333` |

The entry-provider state is
`%TEMP%/xgskins-winxp-responsive-page-provider-failure.json`. The row-height
state is `%TEMP%/xgskins-winxp-responsive-height-failure.json` and the levels
continuation's `uia-timeout.json`. Combined coverage retains both failures.

## Raw Clock automation-response failure

The initial Raw Clock navigation/data, interpreter, useful-bounds and timer
checks passed. After an XP-to-Dark service palette change, `OpenRawClock` timed
out making a Controls request. A native diagnostic then found an owned window
with the exact title `Microsoft Visual C++ Runtime Library`, class `#32770`,
HWND 263756, reported invisible. Input stopped. This is a fatal runtime-error
condition, distinct from the earlier provider-readiness interruptions.

The debugger was interrupted at 11:07:40 PST to inspect the main thread. Its
stack showed `abort`/`terminate` reached from the `HttpAutomationService::DumpTreeAsync`
catch in imported `GacUI.Windows.cpp:14770`, after the response-send call at
line 14766. Recovering the active C++ exception record at `0x000000f8c87da0f0`
identified the thrown object at `0x000000f8c87da658`. Inspecting it as `vl::Error`
returned the exact description:
`HttpSendHttpResponse failed for responding UTF-8 body.`
This proves the `SendResponseUtf8` failure reached the catch that deliberately
terminates. No second-chance exception was reported before that native abort
dialog; the handled exception and explicit termination account for this path.

The capture of PID 27980 began after the abort dialog opened. It preserved a
149,324-character response and the send exception. The original UI-thread stack
during the delay, the active UI Automation listeners and the native Windows error
are unknown. Later replays measured all three. [Skin-switch replays](#raw-clock-skin-switch-replays)

After capturing and revalidating the exact Abort button, one bounded posted
`BM_CLICK` activated it. The dialog disappeared within 0.6 seconds. CDB's
`.lastevent` then reported process `0:6d4c` exiting with code 3 at
2026-11-18 11:13:41.567 PST; the debugger was subsequently closed with `q`.
This was deliberate termination through the native runtime-error dialog,
not the application's normal Exit command. Process 27980 provides no clean-exit
or CRT leak-audit result. The dialog capture and action are retained in
`%TEMP%/xgskins-winxp-runtime-dialog.json` and
`%TEMP%/xgskins-winxp-runtime-abort.log`.

Evidence is `%TEMP%/xgskins-winxp-RawClock.log`, with artifacts in
`RawClock-20261118-190629-698` under the verification directory. The queued
Touching and SharedPayload scenarios had not started when input stopped.
The recovered exception and stack remain in
`%TEMP%/xgskins-winxp-progress-debugger.log`. The fresh application run uses
bounded 60-second client requests for the remaining checks; that verification
adjustment is not a fix for the response-send termination behavior.
VlppOS still omits the native Windows result when the response send fails.
[VlppOS diagnostic issue](../suggestions/VlppOS/HttpResponseErrorCode.md)

Fresh process 25932 subsequently passed 160 Raw Clock assertions with zero
unavailable dialog completions: navigation/data/timer/bounds, raw-element
retention across palette replacement, and UIA names/page selection/resize and
leave/return behavior. The helper completed normally and restored XP.
The client used a bounded 60-second request and verified old-provider retirement
plus a fresh selected DarkSkin provider before the next Controls dump. Evidence
is `%TEMP%/xgskins-winxp-final-RawClock.log`, with artifacts in
`RawClock-20261118-192620-440`. This separate successful run does not establish
the original send failure's cause, prove the client adjustment fixes it, or
erase the failed process and exit code 3.

### Raw Clock skin-switch replays

On November 20, three Debug x64 replays of xgSkins `5c8a5e4` exceeded the
15-second deadline while Windows UI Automation subtree listeners were active.
The HTTP worker accepted the `Controls` GET, then queued the tree dump on the
UI thread behind the XP-to-Dark theme refresh. As the old templates were removed,
`WindowsUIAutomationContext::RetireSubtree` repeatedly scanned the bounds hooks
and automation nodes. In the 37.32-second refresh, 83 of 97 UI-thread samples
were in that function. Across the three replays, the request spent 20.809–37.341
seconds in the UI queue and 8.45–39.55 milliseconds generating the tree. After
the client timed out, each native send returned error 64 (`ERROR_NETNAME_DELETED`)
in less than a millisecond with zero bytes sent. On the same process, five
switches without the passive listener queued for 2.18–2.83 seconds.
[Historical retirement code](https://github.com/vczh-libraries/GacUI/blob/1b5ef89f6/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationState.Windows.cpp)
· [Archived request timings, stacks and artifacts](https://github.com/vczh-libraries/xgSkins/blob/87ef11f1c3a8fbe65aab422228059c8535a75525/suggestions/GacUI/AutomationResponseFailure.md#root-cause)

On November 21, we rebuilt the same showcase with GacUI `2db1e77f9`. The fix
suspends UI Automation observation during a window's template rebuild and
reports bounds changes through the graphics host. Both builds ran at 1250 × 900
with the same document loaded in both editors and three modeless windows
opened and closed. A separate passive listener subscribed to structure,
property, text and text-selection changes. Each deadline covered the complete
HTTP response.
[UI Automation during theme rebuilds](https://github.com/vczh-libraries/GacUI/commit/f7a05f6ecb5903d21af29894e6bb85aceae915d0)
· [Graphics-host bounds notification](https://github.com/vczh-libraries/GacUI/commit/2db1e77f933194a685f7491da3f70f94f5693972)

| Build and listener | Completed switches | Completed `Controls` GETs | Longest request |
| --- | ---: | ---: | ---: |
| Original, passive listener | 0 of 1 | 22 of 23 | Timed out at 15 s |
| Patched, no passive listener | 6 of 6 | 165 of 165 | 1.176 s |
| Patched, passive listener | 10 of 10 | 752 of 752 | 1.506 s |

On all ten subscribed switches, the first GET returned the previous palette.
On the five XP-to-Dark switches, the next GET returned the 149,324-byte
rebuilt tree in 1.302–1.416 seconds. Raw Clock reopened and ticked, the
listener received 568 structure and 32 property events, and the process
exited with code 0. The complete comparison and client logs are indexed in the
[archived patched-build verification](https://github.com/vczh-libraries/xgSkins/blob/87ef11f1c3a8fbe65aab422228059c8535a75525/suggestions/GacUI/AutomationResponseFailure.md#patched-build-verification).

We repeated the test on the current xgSkins showcase after importing the
published GacUI package. With the four UI Automation handlers active, all
438 `Controls` GETs completed within 15 seconds across three XP → Dark → XP
round trips. The slowest complete response took 1.591 seconds. The client
verified each selected skin and a fresh Raw Clock tick after each switch.
The listener recorded 400 structure events and 26 property events, and the
showcase exited normally with code 0.
[Release package](https://github.com/vczh-libraries/Release/commit/3d518383762cec74bba3dac19f8335c9598d38cf)
· [xgSkins import](https://github.com/vczh-libraries/xgSkins/commit/c2a1b406ac479c8e4719344344d2aba52867aca8)

## Synthetic touch continuation

In process 25932, the initial Touching invocation completed raw transforms,
cancellation/rejected-input fallback, ordinary ListView point checks, the full
TouchingList deletion/recycling/momentum sequence, and XP multiline document
caret/range/scroll/momentum checks. It then threw `ElementNotAvailableException`
in `Pattern<T>` while reading `candidate.Current.Name` at the single-line
phase. The native diagnostic found no runtime-error title. Evidence is
`%TEMP%/xgskins-winxp-final-Touching.log`, artifacts
`Touching-20261118-192824-078`, and
`%TEMP%/xgskins-winxp-touch-singleline-provider-failure.json`.

Only the unfinished XP single-line checks, DarkSkin text checks and final
Touching UIA resize/state checks were selected for
`%TEMP%/xgskins-winxp-final-TouchTextRemaining.log`, artifacts
`Touching-20261118-193110-251`. The existing palette readiness/resize helper
runs before acquiring DarkSkin providers. This first continuation stopped
before its body because `WaitForInputIdle(10000)` returned false after viewport
resize; a fresh snapshot confirmed the requested 1,000-by-600 size in
`%TEMP%/xgskins-winxp-touch-resume-idle-failure.json`.

The second continuation, `%TEMP%/xgskins-winxp-final-TouchTextRemaining-resume.log`
with artifacts `Touching-20261118-193217-836`, verified XP single-line short/long
touch and right-click selection preservation. DarkSkin palette readiness then
completed, but the subsequent `Page` lookup threw `ElementNotAvailableException`
before the DarkSkin text group. Its state is
`%TEMP%/xgskins-winxp-touch-dark-page-failure.json`. A fresh-provider Dark-only
continuation in `%TEMP%/xgskins-winxp-final-TouchDarkRemaining.log` then stopped
at its retained-viewport fixture guard before the body. Its artifacts are under
`%TEMP%/xgskins-verification/DarkSkin/Touching-20261118-193356-891`.
The fresh Dark viewport measured 1,000 by 868, while the continuation unnecessarily
required 1,000 by 600; the snapshot is
`%TEMP%/xgskins-winxp-touch-dark-viewport.json`. Only that document-only fixture
guard changed to require positive root bounds. Exact document scrollability,
view size below 50 percent, counters, selection and momentum checks remained.
The temporary `Pattern<T>` helper also stopped fetching `Current.Name` solely
for a diagnostic message after successful `TryGetCurrentPattern`; the required
pattern-availability assertion remains unchanged. The original failing call's
pattern result was not retained. The precise adapter changes and limits are in
[touch pattern diagnostics](../suggestions/FullControlTest/TouchPatternDiagnostics.md) and
[document-touch viewport checks](../suggestions/FullControlTest/DocumentTouchViewport.md).

The final continuation, `%TEMP%/xgskins-winxp-final-TouchDarkRemaining-resume.log`,
passed 157 assertions with zero unavailable dialog completions and normal
helper completion. Its artifacts are under
`%TEMP%/xgskins-verification/DarkSkin/Touching-20261118-193512-923`. It completed
DarkSkin multiline/single-line caret/range/scroll/momentum and final Touching
UIA resize/leave-return checks, without replaying completed XP groups or the
palette action. Combined touch coverage is complete; all four earlier
provider/idle/fixture failures remain retained. Native runtime-error-title
checks remained clear. These are synthetic service/UIA checks, not physical
touch input.

## Shared input payload continuation

The original SharedPayload invocation stopped at `EditorSetValue`'s false idle
assertion before clicking or typing. Evidence is
`%TEMP%/xgskins-winxp-final-SharedPayload.log`, artifacts
`SharedPayload-20261118-193548-612`, and
`%TEMP%/xgskins-winxp-shared-payload-idle-failure.json`.
The narrow continuation required a visible enabled field, one service click
and logical focus, then Home/Shift+End and `!Type:Hello[Ab]{Cd}`. It verified the
exact UIA Value and passed 32 assertions. Its log is
`%TEMP%/xgskins-winxp-final-SharedPayload-resume.log`, artifacts
`SharedPayload-20261118-193714-522`. This preserves the original idle failure
without blanket suppression or replayed typing. It is synthetic input coverage,
not a physical keyboard check. The scoped fixture adaptation is documented in
[keyboard payload field readiness](../suggestions/FullControlTest/KeyboardPayloadFieldReadiness.md).

## Window Manager payloads and native injected input

Service input verified the exact Windows shortcut captions and modifier
readout, Ctrl+Q with localized modal dismissal, 50 button down/up cases and
50 additional move, five-button double-click and two-axis wheel cases across
five modifier combinations. Logs are
`%TEMP%/xgskins-winxp-final-window-manager.log` and
`%TEMP%/xgskins-winxp-final-mouse-payloads.log`. These establish application
listener dispatch. The service KeyPress parser has no supported Windows-key
name; the later native chord checks below supply separate evidence. The
earlier service log's native-input availability wording does not describe the
subsequent native runs.

The native runner subsequently completed in process 25932. Its owned HWND
1049892 was already the foreground window; no foreground or activation call
was made. At logical and physical client size 1,000 by 875, native WM_POINTER
single/multiple contacts, original-contact-first lift, cancelled Up,
rejected-touch OS mouse fallback, independent unpromoted Windows mouse input,
and TouchingList outside-window drag, virtualization and fresh touch passed.
Evidence is `%TEMP%/xgskins-winxp-final-native-input.log`. This verifies native
injection and acquisition, not physical touch/mouse hardware, additional
monitor DPI configurations or rendered pixels. The earlier failed screenshot
captures remain unavailable evidence.

The native Window Manager supplement passed five-button down/up exact labels
and theme style, then local Ctrl+Alt+Win+Q's exact callback dialog and dismissal.
Global Ctrl+Shift+Alt+Win+Q injection was accepted and all injected keys released,
but the ten-second dialog wait failed. Without replaying the chord, a fresh
Controls query independently observed exactly
`You pressed Ctrl+Shift+Alt+Win+Q!` in one modal. Its observed localized dismissal
button was clicked once and the modal disappeared. This is a verified late
semantic outcome, with the original timed wait still failed; no foreground
activation or chord retry occurred.

Evidence is `%TEMP%/xgskins-winxp-final-native-window-manager.log`,
`%TEMP%/xgskins-winxp-native-global-late-result.txt`, and saved
`xp-native-window-manager-buttons.json`, `-Local.json` and `-Global.json` under
`%TEMP%/xgskins-verification/WinXPSkin`. Native injection does not establish
physical keyboard input or the exact completion time of the global callback.

## Progress-layout failure in process 4572

At 08:00:39 PST, changing the horizontal tracker in `Layout / Repeat` to an
intermediate progress value caused a second-chance C++ exception. The debugger
stack reached `GuiTableComposition::Layout_UpdateCellBoundsPercentages` at
`GacUI.cpp:29426`, through the array index check at `Vlpp.h:2207`. Inspection
showed two row options but an empty row-size array, with a 14-pixel available
dimension. The table's parent vtable identified `winxpskin::ProgressChunkTemplate`.

The source bound the repeater's item source directly to cached fill bounds.
Changing those bounds synchronously rebuilt the progress chunks during the
bounds-update pass, after measurement had already occurred. A newly inserted
chunk table therefore reached the percentage-layout calculation before its
size array had been populated.

The implemented local correction retains the requested count in an XML
binding, then queues and coalesces its publication to the property that drives
the repeat stack. The main-thread callback independently captures a shared
lifetime state, checks that it is active before accessing the template, clears
its queued flag and publishes the latest requested count. The template
destructor marks the state inactive. There is no decorative animation or timer;
the purpose is to rebuild children after the current layout traversal returns.
The rationale and upstream proposal are in
[ProgressChunkLayoutMutation.md](../suggestions/GacUI/ProgressChunkLayoutMutation.md).

Generation for this correction completed for x32 and x64, and the generated
C++ files merged successfully. The corrected `Debug|x64` application built with
zero warnings and zero errors in 18.39 seconds. The result was verified against
the upstream wrapper's actual `Build.log`; evidence is in
`%TEMP%/xgskins-winxp-progress-gacbuild.log` and
`%TEMP%/xgskins-winxp-progress-build.log`. Review of the merged callback confirmed
the shared-pointer lifetime guard, destructor invalidation and native-width
integer range. Process 27980 passed the progress endpoints, resize and
replacement checks recorded above. Evidence is in
`%TEMP%/xgskins-winxp-progress-regression.log`.

The initial regression adapter selected an empty, disabled scrollbar but
expected its enabled grip colors. That assertion failure is retained in
`%TEMP%/xgskins-winxp-progress-regression-grip-fixture.log`. The adapter was
corrected to choose the expected normal or disabled palette from the actual
scrollbar state, then reran the checks successfully. This was a fixture
expectation error, distinct from the earlier layout crash.

The six runtime skin replacements verify progress retention and template
recreation. They did not deliberately force destruction at the exact instant
a callback was queued. The shared lifetime guard was reviewed separately in
the generated code; that review is not a runtime test of the precise race.

The original stack and inspected values remain in
`%TEMP%/xgskins-winxp-debugger.log`. Continuing the noncontinuable exception
reached an access violation at the same layout calculation; the process was
then terminated with the debugger's `q` command. This was a failed runtime
check, not a normal application exit. No CRT leak-audit result is claimed for
that process.

## Runtime limitations and process exit

Two native screenshot attempts failed after selecting the window afresh, with
the XP `Layout / Repeat` page settled at 1,200 x 800 and progress 5/10.
`IGraphicsCaptureItemInterop.CreateForMonitor` rejected the monitor with
`0x80070057`. The session had already reported `WTSDisconnected`. No pixels were
captured, so composition values, bounds and successful service/UIA assertions
are not presented as native pixel verification. The capture attempts did not
activate the application or send input.

After the final grid checks, the actual top-level Exit page exposed the visible
`self.Close() (InvokeInMainThread)` button at `(25,127)-(201,144)`. One service
click at `(113,135)` returned `Queued`. An exact native
`Microsoft Visual C++ Runtime Library` title check was clear before closing.
The main window disappeared and the service closed. CDB's `.lastevent` reported
process 25932 (`0:654c`) exiting with code 0 at 2026-11-18 11:50:51.928 PST.
The debugger was then closed with `q`, also returning exit code 0. The saved
pre-exit state is `%TEMP%/xgskins-winxp-final-exit-state.json`.

The completed `%TEMP%/xgskins-winxp-final-debugger.log` contains zero occurrences
of `Detected memory leaks`, `Dumping objects` or `second chance`. It does retain
one Direct2D debug warning reporting 1,001 unreleased interfaces. Thus the final
process completed normal application shutdown without a reported CRT leak dump
or second-chance exception; this is not a broad COM/Direct2D leak-free claim.
The original progress-crash process and HTTP-response Abort process remain
separate failed runs.

Required runtime coverage is complete across the preserved invocations.
Physical hardware input, additional-monitor DPI and native pixels remain unverified.
The earlier disconnected-desktop focus failures are distinct from the later
foreground-owned native injection runs. The global hotkey's late callback was
verified, while its original ten-second wait remains failed. Source/API,
serialization, responsive-layout and provider/idle limitations are retained
where observed; no uninterrupted full-suite pass is claimed.

Machine-local generation, build, debugger and runtime evidence remains under
`%TEMP%`; it is not committed as a build product.
