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

## XP document-touch continuation

The fresh WinXPSkin run in PID 25932 stopped in the single-line section of
`TouchTextSelectionAutomation`. Its stack identifies `Pattern<T>` reading
`element.Current.Name` while constructing a diagnostic, not a failed gesture
assertion. The helper evaluates that property even when pattern acquisition
succeeds. The available stack does not identify which pattern acquisition
was being attempted or prove its result. See
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
and the temporary `xgskins-winxp-final-Touching.log`.

Subsequent stops are distinct and remain failed:

- `xgskins-winxp-final-TouchTextRemaining.log` failed the ten-second
  `WaitForInputIdle` Boolean assertion after a resize. Later bounds confirmed
  1000 by 600; that observation does not make the idle assertion pass.
- `xgskins-winxp-final-TouchTextRemaining-resume.log` completed the XP
  single-line checks and palette helper, then failed in `Page` while entering
  the DarkSkin pass. The exact operation inside `Page` is not isolated.
- `xgskins-winxp-final-TouchDarkRemaining.log` stopped before the document body
  at an exact 1000-by-600 viewport guard. A saved service snapshot,
  `xgskins-winxp-touch-dark-viewport.json`, showed settled 1000-by-868 bounds.

The temporary adapter removes the unconditional diagnostic `Name` read while
retaining `TryGetCurrentPattern` and its availability assertion. It resumes
only unfinished groups, does not replay completed palette actions or gestures,
and uses the existing palette retirement/fresh-provider/layout helper. The
document-only DarkSkin continuation requires positive root bounds instead of
an unrelated exact window size. Its existing document scrollability, view size,
selected-endpoint and event-counter assertions remain unchanged. The ordinary
ListView fixture still establishes its required scrolling viewport. No skin,
application, imported library or upstream source is modified.

The latest continuation is recorded separately in
`xgskins-winxp-final-TouchDarkRemaining-resume.log` under the Windows temporary
directory. It passed 157 assertions for the remaining DarkSkin document touch
and UIA Touching resize/state checks, with zero unavailable dialog completions.
Together with the earlier completed groups, this finishes the combined
synthetic Touching coverage. It does not turn the original interruptions into
passing calls or establish an uninterrupted run or physical-touch verification.

Upstream should avoid optional diagnostic property calls on successful pattern
lookups; obtain a name only on failure, with a fallback if its provider retired.
Separate navigation actions from bounded fresh-provider observation so retries
cannot replay `Select` or input. Give document-only tests their actual
scrollability and geometry preconditions rather than borrowing a ListView
window-size assumption. Test continuations after template replacement while
retaining exact selection, gesture-count and state assertions.
