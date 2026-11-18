# The document-touch continuation assumes an exact window size

A document-touch continuation can stop on an idle or viewport guard before the gestures it is intended to exercise.

## Repro

In `FullControlTest /D2D /Hosted`, continue the WinXPSkin
`TouchTextSelectionAutomation` checks after resizing to 1,000 by 600, then switch to
DarkSkin for the document checks. Three observations were recorded independently.

- `xgskins-winxp-final-TouchTextRemaining.log` failed the ten-second
  `WaitForInputIdle` Boolean assertion after a resize. Later bounds confirmed
  1000 by 600. The idle assertion had already failed.
- `xgskins-winxp-final-TouchTextRemaining-resume.log` completed the XP
  single-line checks and palette helper, then failed in `Page` while entering
  the DarkSkin pass. The exact operation inside `Page` is not isolated.
- `xgskins-winxp-final-TouchDarkRemaining.log` stopped before the document body
  at an exact 1000-by-600 viewport guard. A saved service snapshot,
  `xgskins-winxp-touch-dark-viewport.json`, showed settled 1000-by-868 bounds.

## Workaround

Resume only unfinished groups and use fresh providers after each theme change. For the
document-only pass, require positive root bounds and keep the existing document
scrollability, view size, selected-endpoint and event-counter assertions. The ordinary
ListView fixture still requires an overflowing viewport. The DarkSkin continuation
passed 157 synthetic touch and UIA resize/state assertions, with zero unavailable
dialog completions. See `%TEMP%/xgskins-winxp-final-TouchDarkRemaining-resume.log`.
[Related ListView fixture](TouchingListViewViewport.md).

## Root Cause

The document continuation reused a 1,000-by-600 guard from the ListView setup. Its
saved snapshot showed a positive 1,000-by-868 viewport. The cause of the earlier
failed ten-second `WaitForInputIdle` and the exact operation that failed inside `Page`
remain unknown.
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).

## Proposal

Use each fixture’s required scrollability and geometry. Separate navigation actions
from bounded observation of fresh providers so a lookup retry cannot replay input.
Keep the original assertion results and cover template replacement, resize and gesture
counts. [Pattern lookup interruption](TouchPatternDiagnostics.md).
