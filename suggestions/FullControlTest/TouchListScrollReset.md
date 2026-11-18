# The touch-list test resets scrolling when all rows fit

The momentum test can request a vertical scroll position on a list whose entire contents are visible.

## Repro

In `FullControlTest /D2D /Hosted` with Win7Skin, run the `Touching` scenario through
the momentum test on **Misc / TouchingList**. Clear the list and add five items at the
test’s enlarged window size, then inspect its UIA `ScrollPattern`. In the recorded run
the helper’s unconditional `SetScrollPercent(ScrollPattern.NoScroll, 0)` raised
`InvalidOperationException`.

- Five repopulated rows, each 112 pixels high, inside a 720-pixel-high viewport.
- `VerticallyScrollable == false`.
- `VerticalScrollPercent == ScrollPattern.NoScroll` (`-1`).
- `VerticalViewSize == 100`.

## Workaround

The temporary local adapter checks the five-row fixture and all three UIA
scroll properties above, omits that single inapplicable reset, and retains the
remaining horizontal-momentum deletion, identity and closed-row assertions.
Document-touch and UIA resize checks remain part of the resumed scenario.
No application, skin, imported library or upstream source is changed for this
adaptation.

## Root Cause

The call is in `TouchingListAutomation` in
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs#L852),
after Clear and repopulation during momentum playback. The earlier ten-row
and thirty-row portions of the same scenario require scrolling. The later
five-row fixture can fit after the test resizes the application.

At this viewport the vertical axis has no scroll range. Setting a numeric percentage on that axis is invalid.

## Proposal

Update the upstream helper to wait for the repopulated layout, then call
`SetScrollPercent` only when `VerticallyScrollable` is true. Otherwise, require
`NoScroll` and a 100 percent view size before continuing the same assertions.
Exercise both a viewport that fits five rows and one that requires scrolling.
