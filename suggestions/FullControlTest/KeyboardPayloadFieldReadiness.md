# The shared keyboard test requires global idle before typing

A process-wide idle check can stop the shared-input test before the target field receives any input.

## Repro

In `FullControlTest /D2D /Hosted`, select WinXPSkin and run the `SharedPayload`
scenario on **Control / TextBox / TextBox**. Observe the field’s visibility, enabled
state, bounds and focus before the helper types.

The XP `SharedPayload` run stopped in `EditorSetValue` at the false
`WaitForInputIdle` assertion `dialog input becomes idle before clicking a
field`. The assertion precedes the field click and typing, so the payload had
not been entered. The original failure is retained in
`xgskins-winxp-final-SharedPayload.log` under the Windows temporary directory.

## Workaround

The temporary continuation waits up to 30 seconds for an enabled, visible field with
positive bounds. It clicks once, verifies logical focus, selects the line with Home
and Shift+End, and sends `!Type:Hello[Ab]{Cd}` once. It checks the exact UIA
`ValuePattern` string. The resumed service-input run passed 32 assertions. The
original idle failure and later result are retained in separate logs.
[XP verification](../../doc/WinXPSkinVerification.md#shared-input-payload-continuation).

## Root Cause

`EditorSetValue` treats the Boolean result of `WaitForInputIdle` as a prerequisite for
the field click. The recorded timeout occurred before the first click or character.
Its cause is unknown.
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).

## Proposal

Track the global idle result separately. Wait for the specific field, click once,
verify focus before typing and compare its exact UIA value. Exercise the sequence
after a theme change and with background timer activity. A failed observation should
not replay input.
