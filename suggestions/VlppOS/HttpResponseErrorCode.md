# HTTP response errors lose the Windows result code

The Windows HTTP wrapper reports the same exception text for different failed UTF-8 response sends.

## Repro

In `FullControlTest /D2D /Hosted`, run the WinXPSkin **Misc / Raw Clock** check,
switch to DarkSkin and reopen Raw Clock through the automation service. Keeping
Windows UI Automation subtree listeners active during the switch reproduces the
timeout with a 15-second client deadline on the historical Debug build. In the
original run the client timed out and the debugger recovered
`HttpSendHttpResponse failed for responding UTF-8 body.` The exception identified the
operation but omitted the Windows result.
[GacUI response failure and debugger artifacts](../GacUI/AutomationResponseFailure.md).

## Workaround

On a build with symbols, inspect the local `result` immediately after
`HttpServerApi::SendResponse` returns, before the wrapper throws.

## Root Cause

`SendResponse` returns the result of `HttpSendHttpResponse`. `SendResponseUtf8` passes
every nonzero result to `CHECK_ERROR` with a fixed message. In three timed replays
the client expired while the tree request was queued behind GacUI's theme
refresh. The subsequent native send took less than a millisecond and returned
64 (`ERROR_NETNAME_DELETED`) with zero bytes sent. The UI-thread measurements
and the original incident's evidence limits are in the linked GacUI report.
The original exception did not preserve its native result. The affected
imported wrapper is at lines 5987–5990.
[<VlppOS-repo>/Source/InterProcess/Windows/HttpServerApi.Windows.cpp](https://github.com/vczh-libraries/VlppOS/blob/master/Source/InterProcess/Windows/HttpServerApi.Windows.cpp)
· [Imported VlppOS.Windows.cpp](../../Import/Release/VlppOS.Windows.cpp).

## Proposal

Preserve the native result in the error returned or reported to callers. Cover
distinguishable response-send errors, and verify that the automation service can
include the actual Windows result in its request diagnostics.
