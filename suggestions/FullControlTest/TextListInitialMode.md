# Rerunning the TextList test inherits Radio mode

The List UIA scenario assumes that TextList starts in Text mode. The showcase retains
the previous run’s display mode across skin changes.

## Repro

In `FullControlTest /D2D /Hosted`, run the List scenario under Win7Skin. Leave
**List / TextList** in Radio mode, switch to Win8Skin in the same process, then run
List again.

The Win8Skin List verification initially stopped at
`Unexpected TogglePatternIdentifiers.Pattern on 111`. The preceding Win7Skin
List followup had left the TextList page in Radio mode. Changing the skin
preserved that application state. `list-initial-mode-observation.json`
confirmed the combo box still selected `Radio`.

## Workaround

The temporary adapter explicitly selects `Text` and invokes `Clear` through
the UI before the existing scenario assertions. Its existing item-name checks
remain relative to the fixture's continuing serial counter. No assertion is
removed, and no application or imported source is changed. The initial stop
remains in `remaining-sweep.log`. Rerun results are recorded separately.

## Root Cause

The upstream `TextLists` helper in
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
adds items and initially requires the retained row to have no Toggle pattern.
It then tests Check and Radio modes, ending in Radio mode without restoring
Text. The assumption holds on a fresh application but not on a second run in
the same process. The showcase's
[TextListTabPage.xml](../../Test/FullControlTest/UI/FullControlTest/TextListTabPage.xml)
sets both lists' views from this combo box. Radio mode correctly exposes Toggle
for a row, so the initial stop does not demonstrate a skin defect.

## Proposal

Make each focused helper establish its required initial UI state instead of
assuming process startup. Keep the application's state preservation across
theme changes. A regression should run List twice in one process, including a
theme change between invocations, and require both complete assertion sets.
