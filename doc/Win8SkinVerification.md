# Win8Skin verification record

Verification on 2026-11-18 used Windows and a `Debug|x64` build. Runtime checks
use Direct2D hosted windows: `FullControlTest /D2D /Hosted`. Source, build and
runtime evidence are recorded separately. The shared responsive-row shrink
assertion failed, and several checks required isolated resumption. This record
does not claim an uninterrupted full-suite pass.

## Generation and build

- GacBuild completed Win8Skin XML/resource generation for x32 and x64. The same
  generation also included the Win7Skin scrollbar-geometry followup.
- The `Debug|x64` application build completed with zero warnings and zero
  errors in 36.41 seconds.
- x32 resource generation is not a claim of a Win32 application build or
  runtime test.

Generation output is in `%TEMP%/xgskins-win8-gacbuild.log`; the build result was
verified against the upstream build wrapper's `Build.log`.

## Static source checks

- All 13 XML resource files parsed successfully.
- The skin declares 79 unique instance classes, all mapped to affected
  FullControlTest pages in
  [TestGuidance.md](../spec/Win8Skin/TestGuidance.md).
- All 59 theme slots match the DarkSkin registration set, with no missing or
  extra slots.
- All 115 color-package fields are used and documented in
  [ColorPackage.md](../spec/Win8Skin/ColorPackage.md), with no undefined palette
  references or color literals outside `Win8Skin.xml`.
- All 38 legacy applied-state button palettes and all four editor palettes
  matched the extracted C++ reference data exactly. The five ribbon palettes
  are documented extensions; normal/disabled ribbon faces retain the legacy
  RGB values with zero alpha.
- Local documentation links and whitespace checks passed.

The implementation and research sources are described in
[Win8Skin.md](Win8Skin.md). Build and launch instructions are in
[FullControlTest.md](FullControlTest.md).

## Runtime checks

Verification began in process 4044 under the debugger. After its normal exit,
process 13912 ran the same unchanged binary for the isolated remaining checks.
The first document-editor SOP invocation stopped before completing; its
failure is recorded below rather than counted as an uninterrupted suite pass.

| Check | Observed result |
| --- | --- |
| Startup and skin selector | DarkSkin selected initially, with exactly the DarkSkin, Win7Skin and Win8Skin entries. |
| Animation endpoints and interruption | Button/radio normal, hover, pressed, disabled and restored colors reached their exact endpoints. Group captions passed enabled/disabled/restored states; editors passed normal/hover/focus/disabled/restored states. Rapid button/editor reversals retained the newest target. Checkbox endpoint checks also passed after the sampling adjustment described below. |
| Animation consumers | Toolbar, ribbon, scrollbar thumb/arrow and tracker endpoints passed. A popup dismissed 23 ms into its hover transition remained closed after 250 ms, with the application alive. |
| Checkbox and radio geometry | Checkbox and radio frames measured 13 pixels; the checkbox used the 16-pixel Webdings glyph and the radio used a solid 7-pixel bullet. |
| Scrollbar, tracker and progress geometry | Scrollbar arrows, end insets, minimum thumb and populated-list scrollbar width measured 16 pixels. Tracker channels measured 4 pixels, with 6-pixel end padding and 16 x 10-pixel grips. Progress used the flat `#06B025` fill, `#E6E6E6` background and `#BCBCBC` border. |
| Text controls | 214 assertions passed, with Text run before grid popup lifecycle checks. |
| Resumed document-editor SOP | 2,095 assertions passed from the existing step-14 boundary: Toolstrip UIA hyperlinks/images/edit modes and the style-gallery checks. The earlier interruption and first resume's overwrite collision are recorded below. |
| Combined document-editor coverage | The initial and resumed runs together completed all deep-feature groups for Ribbon and Toolstrip through service IO and UIA: clipboard/editing, formatting and dialogs, hyperlinks, images, edit modes, cancellation, undo/redo and persistence, including private reload and RTF/HTML exports. |
| Style gallery within the resumed SOP | All eight Win8 styles passed inline service-pointer activation and popup tests at widths 1,400, 650 and 1,250, plus six sample entries and private-format reload. DarkSkin refresh passed inline UIA selection, the same popup widths and six UIA sample entries. These checks are included in the 2,095 count; no separate gallery-only total was emitted. |
| Win8 context-menu UIA supplement | 369 assertions passed for Ribbon and Toolstrip: 13 items/five separators, shortcut captions, shared enablement, Object ExpandCollapse, editing commands and selection preservation. Commands used UIA Invoke; opening used synthetic service pointer input. |
| Win8 inline style gallery through UIA | 192 assertions passed for all eight styles through SelectionItem, using the active editor's foreground for ordinary styles and preserving explicit style colors. |
| Showcase walk | 2,687 assertions passed across every page and subpage, including localized dialogs, DatePicker and Window Manager. |
| Lists after explicit fixture setup | 233 assertions passed: the existing list checks plus five assertions for restoring Text mode and clearing the retained fixture. The first invocation's precondition stop is recorded below. |
| Refresh List | 46 assertions passed. |
| Calendar | 39 assertions passed for hosted selection/grid/table behavior. Two desktop-focus lookups were unverified because the Windows session was disconnected. |
| Raw Clock | 118 assertions passed for names, navigation, useful bounds, palette refresh and resize. |
| Resumed synthetic touch checks | 11,059 assertions passed for ordinary ListView point scrolling/clamping/selection; touch-list swipe, identity, virtualization, cancellation and momentum; document/single-line selection, right-input fallback and momentum across Win8Skin/DarkSkin refresh; and Touching UIA resize/state. Earlier raw-contact groups remain in the original invocation. |
| Point-input regression in fresh process 13912 | 2,479 assertions passed for Win8Skin/DarkSkin and Ribbon/Toolstrip, across forward/reversed caret targets and long-press popup dismissal. Unique logical-focus checks were unchanged; desktop-focus lookup remained unverified. |
| EasyLayout across recorded invocations | Initial mixed-layout and table geometry/splitter/rebuild groups completed; all three skins retained control state. The final table-palette/resize resume passed 277 assertions, including the existing `Updated table` payload. The original lookup and palette-configuration stops remain recorded below. |
| Responsive compact-row shrink | **Failed** in process 13912: rows expanded from 26 to 106 pixels, then remained 106 pixels after shrinking back to the compact layout. This matches the earlier Win7Skin/DarkSkin failure. |
| Other responsive-modal checks | 877 assertions passed for widths 350/440, sizes 680 x 220/520, account/movie scrolling, selection/menu behavior and OK/Cancel/title-bar closure. The compact shrink failure remains failed. |
| Shared text payload | 34 assertions passed for exact `Hello[Ab]{Cd}` service typing, verified through UIA ValuePattern. This is synthetic service-input coverage. |
| Window Manager and mouse payloads | Exact shortcut captions, the Ctrl+Q modal, 50 down/up event/modifier combinations and 50 additional move/double-click/wheel combinations passed, including exact readout and theme font/color checks. |
| Bindable data grid, run last | 59 assertions passed for grid editing, including text, selection and date editors, in `Grid.log`. |

The initial endpoint script sampled the checkbox before its preceding selected
transition had settled. The resumed adapter waited for `CheckedNormal` before
testing the next state; the checkbox and remaining editor checks then passed.
The first log's stop is retained as an adapter timing failure, not a complete
run pass. Evidence is in `animation-endpoints.log`,
`checkbox-editor-endpoints.log`, `animation-consumers.log` and
`scroll-tracker-progress-geometry.log` under
`%TEMP%/xgskins-verification/Win8Skin`.

A native capture immediately after asynchronous theme selection contained
stale Win7Skin List pixels. The first control snapshot already contained Win8
colors but its new frame still had zero bounds; later pre-resize endpoint
snapshots showed a nonzero 656 x 880 Win8 frame and the expected palette. The
capture is therefore inconclusive for Win8Skin pixels and does not demonstrate
a persistent layout failure. The checks above use control state, composition
values and bounds, which do not establish the pixels actually presented.
The editor SOP also reported an unverified desktop-focus lookup because the
Windows session was disconnected. UIA selection/focus assertions and service
IO are distinct from native foreground input; no physical mouse, keyboard or
touch coverage is claimed.
The Windows-key shortcut caption was checked, but the automation parser
rejected the Windows-key name. `Ctrl+Alt+Win+Q` activation and the native
global-hotkey route were not verified. Window Manager evidence is in
`window-manager-io.log` and `shared-mouse-payloads.log`.

The document-editor SOP's context-menu groups use Win8Skin for service IO,
then refresh to DarkSkin for the UIA context phase. The upstream adapter's
older theme label does not describe the selected skin. These groups establish
Win8Skin service-input and DarkSkin UIA-context coverage. A separate
`ThemeContextUia.log` invocation supplied the Win8Skin UIA-context coverage
recorded above. UIA has no point-injection or context-menu-open pattern, so
menu opening used synthetic service input. Where synthetic Escape did not
dismiss a nonactivating menu, the adapter clicked outside and verified closure.

## Document-editor SOP interruption

The first invocation stopped with `ElementNotAvailableException` during the
Toolstrip editor's UIA hyperlink route 0 save/reload sequence. The saved
`hyperlink-1-1.bin` existed at 117,758 bytes, and an automation-service snapshot
showed a newly opened Load dialog. The first three deep-feature combinations
had completed, along with Toolstrip UIA clipboard, formatting, dialog and
export groups. The application remained running under the debugger, without
a crash or debugger exception break at that point.

The adapter cancelled the unfinished Load dialog, reacquired providers through
a fresh runner and resumed at the existing `StartStep = 14` boundary for
hyperlinks, images, edit modes and the gallery. Assertions were unchanged.
The original stop is retained in `DocumentEditorSop.log` and `full-sweep.log`;
the resumed invocation uses `DocumentEditorSop-resume14.log`. These records
must be interpreted together rather than as an uninterrupted full-SOP pass.
The first targeted resume reused an already saved artifact and encountered
an unhandled overwrite prompt. The adapter cancelled that prompt and selected
a fresh temporary output directory, preserving the earlier files and logs.
This second stop was an adapter setup collision, not a demonstrated skin or
runtime defect. The isolated-output invocation uses
`DocumentEditorSop-resume14-fresh.log` in the same process and completed with
2,095 passing assertions.
The original exception's precise failing call remains unconfirmed because its
stack was truncated. The evidence, temporary runner changes and proposed
harness improvement are documented in
[FullControlTestModalAutomation.md](../suggestions/FullControlTestModalAutomation.md).

## Process exits

Process 4044 closed through the application's Exit action with code 0 at
06:46:33 PST. Its completed debugger log contained no CRT leak report or
second-chance exception. Direct2D emitted one runtime allocation-count warning
for 1,001 live interfaces; absence of a CRT report does not verify interface
lifetimes. Evidence is in `%TEMP%/xgskins-win8-debugger.log`.

Process 13912 also closed through the application's Exit action with code 0
at 07:12:32 PST. Its completed `%TEMP%/xgskins-win8-fresh-debugger.log` likewise
contained no CRT leak report or second-chance exception. A runtime Direct2D
allocation-count warning for 1,001 live interfaces was again present.

## Shared runtime issues and coverage interpretation

The imported runtime still contains the hosted-window focus lifetime defect
documented in
[HostedWindowLastFocusedWindow.md](../suggestions/HostedWindowLastFocusedWindow.md).
That earlier focus-lifetime crash was not reproduced in the Win8 runs.
The responsive movie-list row-height failure did reproduce with Win8Skin:
240 x 320 compact rows measured 26 pixels, expanded to 106 pixels at
680 x 320, then retained 106 pixels after returning to 240 x 320. The source
diagnosis and earlier Win7Skin/DarkSkin evidence are in
[ResponsiveListRowHeight.md](../suggestions/ResponsiveListRowHeight.md).
`ResponsiveWindow.log` and `responsive-shrink-failure.json` preserve this
failed assertion. Earlier responsive ribbon/document/view/stack/group,
vertical-header and Alt+E checks completed before it; later isolated checks
do not erase the failure.

Win8Skin includes the local animation endpoint completion helper described in
[FiniteAnimationEndpoint.md](../suggestions/FiniteAnimationEndpoint.md).
The XML gradients retain linear 120 ms timing. The endpoint and interruption
checks above verify the local completion behavior.

The first Win8 Ribbon point-regression case stopped at the assertion requiring
one reachable logical focus. The caret-equivalence checks had passed, but UIA
reported both the inline Style gallery List and Document as keyboard-focused
and onscreen. The saved ancestor chains placed both live controls under Ribbon,
without a popup. `point-focus-observation.log` and its control snapshot retain
this observation. It is a failing assertion with an unconfirmed cause, not a
passing point-regression run or an established skin defect; the assertion was
not removed. Source inspection confirms that both UIA reports use the controls'
logical focus flags rather than treating gallery selection as focus. The
retained-focus disconnection path and proposed regressions are documented in
[RetainedLogicalFocus.md](../suggestions/RetainedLogicalFocus.md); that path has
not been traced as the trigger for this observation.
After normal closure of process 4044, the unchanged point suite passed 2,479
assertions when run first in fresh process 13912. This isolation does not erase
the earlier failure or prove its trigger. The initial run is preserved in
`PointRegression-contaminated4044.log`; the fresh run is in
`PointRegression.log` and `fresh13912-sweep.log`.

The verification adapter used the existing
[search-field shortcut routing](../suggestions/FullControlTestShortcutRouting.md)
and [theme-derived document colors](../suggestions/FullControlTestSkinColors.md)
adjustments. Popup gallery backgrounds do not expose UIA Invoke; their UIA
discovery/scrolling plus service-pointer activation is mixed coverage, as
described in
[FullControlTestGalleryAutomation.md](../suggestions/FullControlTestGalleryAutomation.md).

The initial focused List invocation inherited Radio mode from the earlier
Win7Skin followup and stopped at its expected-no-Toggle assertion. The adapter
explicitly selected Text mode and cleared the fixture through the UI before
rerunning the unchanged assertions. The original failure is retained in
`remaining-sweep.log`; the rerun passed 233 assertions in `List.log` and
`focused-sweep.log`. The retained-state precondition and proposed harness
regression are described in
[FullControlTestFixtureState.md](../suggestions/FullControlTestFixtureState.md).

The initial Touching invocation completed raw contact transforms, cancellation
and rejected-sequence/fallback groups, then stopped at the ordinary ListView
scrollability precondition. The inherited 1,400 x 950 window gave both lists
770-pixel viewports, enough for all 29 rows, so there was no vertical scroll
range. The resumed adapter explicitly resized through UIA to 1,000 x 600 and
continued at the ordinary ListView test, retaining its scrollability assertion
and all subsequent checks. The same fixture-state note records this setup;
`Touching.log` and `focused-sweep.log` preserve the initial stop, while
`TouchListAndText.log` records the resumed segment's 11,059 passing assertions.
The adapter retained the previously documented
[touch-list no-scroll guard](../suggestions/FullControlTestTouchAutomation.md),
but its diagnostic branch did not execute in this Win8 run: the reset was valid
at the explicit viewport. This is not Win8 coverage of that guard branch.

EasyLayout completed its initial docking, control rebuild, splitter and resize
groups, then attempted the next tab lookup before the asynchronously rebuilt
theme tree was available. The original `Missing ControlType.TabItem: Window
Manager` stop is preserved in `EasyLayoutOnly.log` and `fresh13912-sweep.log`.
A subsequent snapshot showed the rebuilt DarkSkin Window Manager. The resumed
adapter uses a bounded 30-second wait, reacquiring the root until its Window
Manager tab exists, then keeps the existing palette-retention, geometry and
table assertions. This settle condition is also documented in
[FullControlTestFixtureState.md](../suggestions/FullControlTestFixtureState.md).
The resumed three-skin retention, table geometry, splitter and rebuild groups
then completed before the separate upstream table-palette loop requested the
nonexistent `Ember` entry. `EasyLayoutPaletteResume.log` preserves that harness
configuration stop. The adapter maps the remaining loop to DarkSkin, Win7Skin
and Win8Skin, retaining its table-payload, geometry and final resize assertions.
`EasyLayoutTablePaletteResume.log` completed with 277 passing assertions.
Together these invocations cover the mixed/table scenario with the actual
three-skin selector; they are not one uninterrupted EasyLayout pass.

Runtime logs and snapshots are retained under
`%TEMP%/xgskins-verification/Win8Skin`. Generation, build and debugger records
use the `%TEMP%/xgskins-win8-*` prefix. These machine-local evidence files are
not committed build products.
