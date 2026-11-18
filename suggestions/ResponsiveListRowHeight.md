# Responsive list rows retain their larger height

The FullControlTest `ResponsiveWindow` scenario fails identically with DarkSkin,
Win7Skin, Win8Skin and WinXPSkin under `/D2D /Hosted`. This is a shared list-layout problem.
No skin or upstream source is changed
to work around it.

## Reproduction

1. Open **Layout / Easy Layout (Responsive)** at a client size of 240 by 320.
   Movie rows show only titles and measure 26 pixels high.
2. Resize directly to 680 by 320. Rows show their image, title, and author and
   measure 106 pixels high. Scroll the movie list to the end and back to the top.
3. Resize directly to 240 by 320. Images and authors disappear and the account
   menu returns, but movie rows remain 106 pixels high. Only three titles are
   visible instead of the initial nine.

The existing
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
`ResponsiveLayout` assertion times out at
`movie row height follows responsive appearance #0`. The same runner sequence
reproduces the failure after switching to a fresh DarkSkin template tree.

Win8Skin reproduced the same failure in process 13912: compact rows initially
measured 26 pixels, expanded to 106 pixels at 680 by 320, then retained 106
pixels after shrinking to 240 by 320. The three observed row bounds were
332..438, 438..544 and 544..650. The Win8 evidence is retained in
`%TEMP%/xgskins-verification/Win8Skin/ResponsiveWindow.log` and
`responsive-shrink-failure.json`. Other responsive checks are run separately;
their results do not turn this failed shrink assertion into a pass.

WinXPSkin reproduced the same strict assertion in process 27980 on
2026-11-18. The initial compact rows measured 26 pixels, the detailed rows
106 pixels, and the returned compact rows still measured 106 pixels. The
failure remains in `%TEMP%/xgskins-winxp-ResponsiveLevelsResume.log`, with
`%TEMP%/xgskins-winxp-responsive-height-failure.json` and
`%TEMP%/xgskins-verification/WinXPSkin/ResponsiveWindow-20261118-190354-240/uia-timeout.json`.
After cancelling that modal, the separate `ResponsiveRemaining` continuation
passed 877 additive assertions covering the remaining appearances, accounts,
footer, selection and OK/Cancel/title-bar closure branches. It explicitly
reported the known failure and omitted only the failed compact-row shrink
check; the original predicate and failing invocation were retained unchanged.
Its log is `%TEMP%/xgskins-winxp-ResponsiveRemaining.log`. This is combined
coverage with a reproducible failure, not a complete responsive-scenario pass.

## Source diagnosis

The following read-only source findings explain the observed retained height;
the execution path has not been confirmed with a debugger:

- The showcase's `movieGroup.CurrentLevelChanged` handler calls
  `movieList.Arranger.ReloadVisibleStyles()` after changing the responsive level.
- In
  [GacUI/Source/GraphicsComposition/GuiGraphicsRepeatComposition_Virtual.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/GraphicsComposition/GuiGraphicsRepeatComposition_Virtual.cpp),
  `GuiVirtualRepeatCompositionBase::ReloadVisibleStyles` recreates visible
  styles while deliberately retaining the measured extent. It calls
  `InvalidateLayout`, which does not invalidate the item-size cache.
- `GuiRepeatFixedHeightItemComposition::Layout_BeginPlaceItem` starts with the
  cached `rowHeight`. `Layout_PlaceItem` only increases that height to fit a
  larger preferred size. A replacement compact row therefore cannot reduce
  the retained height. `OnStyleCachedMinSizeChanged` also only invalidates the
  layout. The imported implementation used by this repository has the same
  behavior.

## Proposed upstream correction and regression

Allow a visible-style reload or a preferred-size decrease to remeasure the
fixed-height row cache after replacement styles have valid measurements.
Preserve the scroll anchor and previous extent until that measurement is ready:
the existing reload comment explicitly guards against provisional text sizes
clamping the scroll position of a hidden list. Unconditionally resetting the
layout before measuring would risk reintroducing that problem.

Keep the existing direct compact-to-detailed-to-compact assertion, and add a
focused virtual-repeat regression that changes visible item preferred heights
from 26 to 106 and back to 26. Verify the row height, realized item count,
selection, and scrolling at the start and end of the list. Include a hidden-list
reload case to ensure provisional text measurements do not lose the scroll
anchor. Run the showcase regression with DarkSkin, Win7Skin, Win8Skin and
WinXPSkin.
