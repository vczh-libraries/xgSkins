# Changing progress chunks during layout can interrupt measurement

Changing the number of XP progress chunks while their parent is being arranged can
leave a new table without measured row sizes.

## Repro

Use the original WinXPSkin template that binds `RepeatStack.ItemSource` directly to
the fill’s `CachedBounds`. In a Debug x64 `FullControlTest /D2D /Hosted` run, select
WinXPSkin, open **Layout / Repeat**, and move the tracker from zero to a partial
value. The progress indicator should render its first chunks.

In process 4572, the first new `ProgressChunkTemplate` had two percentage rows and 14
pixels available. At `GuiTableComposition::Layout_UpdateCellBoundsPercentages`,
`dimOptions.Count()` was 2 and `dimSizes.Count()` was 0. The Debug build stopped
before the chunks appeared.
[Verification record](../../doc/WinXPSkinVerification.md#progress-layout-failure-in-process-4572).

## Workaround

Keep the requested chunk count in an XML binding. `QueueChunkCount` coalesces updates
and publishes the latest count from `GuiApplication.InvokeInMainThread` after the
current layout traversal. The repeater binds to the published count. The chunk table,
gradients and geometry remain in XML.
[XP progress template](../../Source/WinXPSkin/UI/Template_Scroll.xml).

Each callback holds an independent shared lifetime token. The template destructor
marks it inactive before teardown. The callback checks the token before accessing the
template and clears its queued flag before publishing so another update can be
scheduled. Cancellation alone cannot cover a due delay already marked `Executing`
before queued tasks run. A queued theme refresh may destroy the template first.
[<GacUI-repo>/Source/Utilities/SharedServices/GuiSharedAsyncService.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Utilities/SharedServices/GuiSharedAsyncService.cpp).

## Root Cause

A synchronous update to `RepeatStack.ItemSource` installs new children from a
bounds-change notification. A table inserted after the current measurement pass
already participates in arrangement. Its row options exist before their measured sizes
do. The GacUI composition-event documentation recommends deferring structural changes.
[<GacUI-repo>/Source/GraphicsComposition/GuiGraphicsTableComposition.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/GraphicsComposition/GuiGraphicsTableComposition.cpp)
·
[<GacUI-repo>/.github/KnowledgeBase/manual/gacui/components/compositions/events.md](https://github.com/vczh-libraries/GacUI/blob/master/.github/KnowledgeBase/manual/gacui/components/compositions/events.md).

## Proposal

An upstream improvement would detect structural changes during bounds traversal and
restart measurement before arranging newly added tables, or reject the mutation with
an explanatory diagnostic. Regression coverage should include changing
zero/partial/full progress, resizing, fast value changes, switching skins with an
update pending, and destroying the containing view before a queued callback executes.
