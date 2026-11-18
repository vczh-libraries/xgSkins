# Finite animations omit their endpoint

A finite color transition can stop before it paints its configured target.

## Repro

Use a FullControlTest build with the original unwrapped Win7Skin XML gradients. In
**List / TextList**, hover a pushbutton, move away and wait longer than 120
milliseconds. Inspect its final paint in the automation service’s `Controls` tree and
compare the four gradient stops and text with the normal palette. The current skin
applies the completion helper below.

Win7Skin button transitions stopped at intermediate colors after their 120 ms
duration. Waiting ten seconds did not change the result. For example, a normal
enabled button retained gradient colors `#F9F9F9`, `#ECECEC`, `#E1E1E1`, and
`#D5D5D5` with text `#141414`, instead of the palette's `#FAFAFA`, `#EBEBEB`,
`#DDDDDD`, `#CFCFCF`, and black text. Hover transitions also retained
intermediate colors.

## Workaround

Win7Skin and Win8Skin wrap their linear 120 ms XML gradients in
`CompleteColorAnimation`. This Workflow coroutine takes an `IGuiAnimation^` and a
completion callback. Generated `Gradient` types are unavailable during the earlier
script compilation pass, so the helper uses existing metadata types in its signature.
[Win7 button template](../../Source/Win7Skin/UI/Template_Button.xml) ·
[Win8 button template](../../Source/Win8Skin/UI/Template_Button.xml).

Calling `CreateAnimation` immediately captures the current colors and the new target.
After the inner animation completes, the wrapper calls `builder.Interpolate(1.0)`. The
template holds the wrapper in `lastAnimation`. Interrupting it cancels the inner
animation and its final transfer, so the next transition starts at the current
intermediate color.

## Root Cause

`GuiFiniteAnimation::Run` invokes its callback only while `currentTime < length`. On
the completion tick `GetStopped` becomes true and the root timer removes the
animation. The callback never receives the final elapsed time.
[<GacUI-repo>/Source/Controls/Templates/GuiAnimation.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/Templates/GuiAnimation.cpp).

The compiler-generated XML `Gradient` calls `Interpolate(currentTime / time)` from
that callback. It has no other path to transfer the target colors. The imported
runtime and generated Win7Skin C++ follow this path.
[<GacUI-repo>/Source/Compiler/GuiInstanceAnimation.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Compiler/GuiInstanceAnimation.cpp).

## Proposal

On completion, invoke the callback once with `min(elapsedTime, length)` before
reporting that the animation has stopped. A zero-duration animation should run its
callback with zero on its first tick. Have XML gradients apply the target directly in
that case.

Cover exact-duration and overshooting ticks, a first tick after the duration, zero
duration, pause/resume and interruption midway through a transition. Assert the exact
final color and verify that a canceled transition cannot overwrite its replacement.
The skin wrappers can be removed once the imported runtime guarantees this behavior.
