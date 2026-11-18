# Responsive list rows retain their larger height

The FullControlTest `ResponsiveWindow` scenario fails identically with DarkSkin
and Win7Skin under `/D2D /Hosted`. This is a shared list-layout problem, not a
Win7Skin decorative-gradient requirement. No skin or upstream source is changed
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
[GacUI-repo/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
`ResponsiveLayout` assertion times out at
`movie row height follows responsive appearance #0`. The same runner sequence
reproduces the failure after switching to a fresh DarkSkin template tree.

## Source diagnosis

The following read-only source findings explain the observed retained height;
the execution path has not been confirmed with a debugger:

- The showcase's `movieGroup.CurrentLevelChanged` handler calls
  `movieList.Arranger.ReloadVisibleStyles()` after changing the responsive level.
- In
  [GacUI-repo/Source/GraphicsComposition/GuiGraphicsRepeatComposition_Virtual.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/GraphicsComposition/GuiGraphicsRepeatComposition_Virtual.cpp),
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
anchor. Run the showcase regression with both DarkSkin and Win7Skin.
