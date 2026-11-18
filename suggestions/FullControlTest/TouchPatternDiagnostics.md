# A diagnostic name lookup can interrupt document-touch verification

The UIA pattern helper reads a provider’s name while constructing a diagnostic,
including when the pattern lookup succeeds.

## Repro

In `FullControlTest /D2D /Hosted`, run `Touching` under WinXPSkin through the
single-line section of `TouchTextSelectionAutomation`. Inspect the original run’s
stack when acquiring the document provider’s pattern. Process 25932 stopped at
`element.Current.Name`. The requested pattern and its acquisition result were not
recorded. The original stack is in `%TEMP%/xgskins-winxp-final-Touching.log`.
[Touch verification](../../doc/WinXPSkinVerification.md#synthetic-touch-continuation).

## Workaround

The temporary adapter preserves `TryGetCurrentPattern` and its availability assertion
while removing the unconditional name lookup. It resumes the unfinished checks with
fresh providers and avoids replaying completed theme changes or gestures. The later
viewport and navigation interruptions are recorded separately.
[Document-touch viewport](DocumentTouchViewport.md).

## Root Cause

`Pattern<T>` eagerly evaluates `element.Current.Name` as part of its assertion
message. Even when the operation itself succeeds, constructing that message can raise
an exception on a retiring provider. The original stack identifies that property read
only.
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).

## Proposal

Look up the optional name only when pattern acquisition fails, and provide a fallback
when the element retires. Test this after a theme refresh while retaining exact
pattern, selection and gesture-count assertions.
