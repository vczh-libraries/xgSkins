# Initialize retained showcase state before focused tests

## TextList mode

The Win8Skin List verification initially stopped at
`Unexpected TogglePatternIdentifiers.Pattern on 111`. The preceding Win7Skin
List followup had left the TextList page in Radio mode; changing the skin
preserved that application state. `list-initial-mode-observation.json`
confirmed the combo box still selected `Radio`.

The upstream `TextLists` helper in
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
adds items and initially requires the retained row to have no Toggle pattern.
It then tests Check and Radio modes, ending in Radio mode without restoring
Text. The assumption holds on a fresh application but not on a second run in
the same process. The showcase's
[TextListTabPage.xml](../Test/FullControlTest/UI/FullControlTest/TextListTabPage.xml)
sets both lists' views from this combo box. Radio mode correctly exposes Toggle
for a row, so the initial stop does not demonstrate a skin defect.

The temporary adapter explicitly selects `Text` and invokes `Clear` through
the UI before the existing scenario assertions. Its existing item-name checks
remain relative to the fixture's continuing serial counter. No assertion is
removed, and no application or imported source is changed. The initial stop
remains in `remaining-sweep.log`; rerun results are recorded separately.

Make each focused helper establish its required initial UI state instead of
assuming process startup. Keep the application's state preservation across
theme changes. A regression should run List twice in one process, including a
theme change between invocations, and require both complete assertion sets.

## Touching ListView viewport

The subsequent Touching invocation stopped at `ListView is vertically
scrollable`. The earlier editor checks had left the application at 1,400 by
950 pixels. Both ordinary ListViews had 770-pixel viewports containing 29 rows
that all fit; UIA correctly reported `VerticallyScrollable == false`.
`touch-listview-precondition-observation.json` records this state. The earlier
raw contact-transform, cancellation and rejected-sequence/fallback groups had
already completed.

`TouchingAutomation` in the same upstream helper assumes this fixture has a
scroll range before exercising point scrolling. The temporary resumed scenario
uses UIA `Transform.Resize(1000, 600)`, waits for idle, then retains the original
scrollability assertion and all later scrolling, touch-list, document-touch
and resize checks. It does not rerun the already completed raw groups or
remove assertions. The initial stop is preserved in `Touching.log` and
`focused-sweep.log`; the resumed segment uses `TouchListAndText.log`.

Give scrolling tests an explicit viewport or a fixture guaranteed to overflow,
and verify the scroll range before injecting gestures. Regression coverage
should start after both small and large-window scenarios and require the same
complete scrolling assertions.

## Rebuilt controls after theme refresh

The EasyLayout-only run completed its initial docking, control rebuild,
splitter and resize checks, then failed `Missing ControlType.TabItem: Window
Manager` immediately after the old DarkSkin palette attachment retired.
`easylayout-refresh-observation.json` subsequently showed the rebuilt DarkSkin
Window Manager. Retirement of the old provider did not establish that its
replacement tree was already available to the next immediate lookup.

The upstream `EasyLayout` helper waits for retirement, reacquires the root,
then immediately calls `Page`. Its `PersistencePalette` helper already uses a
bounded wait for a rebuilt tab. The temporary EasyLayout adapter now reacquires
the root with `AutomationElement.FromHandle` and waits up to 30 seconds until
`FindNamed(root, "Window Manager", ControlType.TabItem)` succeeds before using
`Page`. A permanently missing tab still fails at the timeout.

The resumed portion verifies the retained checked state, Second combo choice
and editor marker, then runs the three actual skin choices and the original
table-layout checks. The geometry and state assertions remain unchanged;
completed initial groups are not rerun. Apply this rebuilt-tree settle
condition consistently after theme replacement, and regress rapid consecutive
refreshes while checking both retained state and current geometry. The initial
stop is preserved in `EasyLayoutOnly.log` and `fresh13912-sweep.log`.

## Available skin choices

The resumed EasyLayout checks completed retention across DarkSkin, Win7Skin
and Win8Skin, followed by table geometry, splitter and rebuild checks. The
table helper then requested `Ember`, an upstream showcase palette absent from
this application's three-entry selector, and stopped at `Missing
ControlType.RadioButton: Ember`. `EasyLayoutPaletteResume.log` retains this
configuration failure.

The separate upstream `EasyLayoutTables` palette loop contains `Ember` and
`Default`; the temporary adapter maps that loop to the three actual skin
entries and resumes only table palette retention and final resize checks.
It waits up to 30 seconds for the rebuilt Layout tab and first verifies the
existing `Updated table` payload. Geometry and retained-payload assertions are
unchanged. Parameterize showcase
palette names in reusable helpers so that extension test applications can
provide their real selector entries without duplicating or weakening tests.

## Shared keyboard payload field readiness

The XP `SharedPayload` run stopped in `EditorSetValue` at the false
`WaitForInputIdle` assertion `dialog input becomes idle before clicking a
field`. The assertion precedes the field click and typing, so the payload had
not been entered. The original failure is retained in
`xgskins-winxp-final-SharedPayload.log` under the Windows temporary directory.

The narrow temporary continuation waits up to 30 seconds for the target field
to be enabled, visible and have positive bounds. It clicks once, requires
logical keyboard focus, selects the line with Home/Shift+End and sends
`!Type:Hello[Ab]{Cd}` once. It then requires that exact UIA `ValuePattern`
value. `xgskins-winxp-final-SharedPayload-resume.log` records 32 passing
assertions. This does not make the earlier idle assertion pass, replay typing,
or suppress idle failures in other helpers. Service character-payload success
does not verify physical keyboard or browser key-code handling. No application,
skin, imported library or upstream source is changed.

For the upstream `EditorSetValue` helper in
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs),
separate global idle diagnostics from field readiness and exact input
postconditions. Use bounded visible/enabled geometry checks, verify focus
before typing, and retain exact payload assertions. Record a timed-out idle
wait independently; never retry an input action merely because its completion
wait failed. Regress this path after template replacement and with background
timer activity.
