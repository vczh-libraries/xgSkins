# Touch-list scroll reset when all rows fit

The Win7Skin `/D2D /Hosted` Touching verification reached the momentum test's
Clear/Add 5 Items step, then failed in the upstream test helper's unconditional
`SetScrollPercent(ScrollPattern.NoScroll, 0)` call. At that point UIA reported:

- Five repopulated rows, each 112 pixels high, inside a 720-pixel-high viewport.
- `VerticallyScrollable == false`.
- `VerticalScrollPercent == ScrollPattern.NoScroll` (`-1`).
- `VerticalViewSize == 100`.

All rows fit, so the helper attempted a vertical scroll operation without a
vertical scroll range. The resulting `InvalidOperationException` does not
indicate a skin or gesture-processing failure.

The call is in `TouchingListAutomation` in
[GacUI-repo/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs#L852),
after Clear and repopulation during momentum playback. The earlier ten-row
and thirty-row portions of the same scenario require scrolling; the later
five-row fixture can fit after the test resizes the application.

The temporary local adapter checks the five-row fixture and all three UIA
scroll properties above, omits that single inapplicable reset, and retains the
remaining horizontal-momentum deletion, identity and closed-row assertions.
Document-touch and UIA resize checks remain part of the resumed scenario.
No application, skin, imported library or upstream source is changed for this
adaptation.

Update the upstream helper to wait for the repopulated layout, then call
`SetScrollPercent` only when `VerticallyScrollable` is true. Otherwise, require
`NoScroll` and a 100 percent view size before continuing the same assertions.
Exercise both a viewport that fits five rows and one that requires scrolling.
