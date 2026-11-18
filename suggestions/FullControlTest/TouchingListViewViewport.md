# The ListView touch fixture can fit all its rows

A large window inherited from another scenario can remove the scroll range required by
the ordinary ListView touch tests.

## Repro

In `FullControlTest /D2D /Hosted`, leave the window at 1,400 by 950 after the editor
checks, then run `Touching`. Inspect the ordinary ListViews when the helper reaches
its vertical-scrollability assertion.

The subsequent Touching invocation stopped at `ListView is vertically
scrollable`. The earlier editor checks had left the application at 1,400 by
950 pixels. Both ordinary ListViews had 770-pixel viewports containing 29 rows
that all fit. UIA reported `VerticallyScrollable == false`.
`touch-listview-precondition-observation.json` records this state. The earlier
raw contact-transform, cancellation and rejected-sequence/fallback groups had
already completed.

## Workaround

The temporary adapter resizes the owner to 1,000 by 600 using UIA, waits for idle and
checks that the list scrolls before continuing the point, document-touch and resize
checks. The initial stop is in `Touching.log` and `focused-sweep.log`. The resumed
segment is in `TouchListAndText.log`.

## Root Cause

`TouchingAutomation` assumes that the ordinary ListView fixture overflows at the
current window size. Both 770-pixel viewports fit all 29 rows after the earlier editor
checks.
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).

## Proposal

Give scrolling tests an explicit viewport or a fixture guaranteed to overflow,
and verify the scroll range before injecting gestures. Regression coverage
should start after both small and large-window scenarios and require the same
complete scrolling assertions.
