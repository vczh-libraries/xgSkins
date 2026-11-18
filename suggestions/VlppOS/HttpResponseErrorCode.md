# HTTP response errors lose the Windows result code

The Windows HTTP wrapper reports the same exception text for different failed UTF-8 response sends.

## Repro

In `FullControlTest /D2D /Hosted`, run the WinXPSkin **Misc / Raw Clock** check,
switch to DarkSkin and reopen Raw Clock through the automation service. If a
`Controls` response send fails, inspect the reported error. In the recorded run the
client timed out and the debugger recovered
`HttpSendHttpResponse failed for responding UTF-8 body.` The exception identified the
operation but omitted the Windows result.
[GacUI response failure and debugger artifacts](../GacUI/AutomationResponseFailure.md).

## Workaround

N/A

## Root Cause

`SendResponse` returns the result of `HttpSendHttpResponse`. `SendResponseUtf8` passes
every nonzero result to `CHECK_ERROR` with a fixed message. The native result was
unavailable in the recorded exception, so the underlying Windows error is unknown. The
affected imported wrapper was at lines 5987–5990.
[<VlppOS-repo>/Source/InterProcess/Windows/HttpServerApi.Windows.cpp](https://github.com/vczh-libraries/VlppOS/blob/master/Source/InterProcess/Windows/HttpServerApi.Windows.cpp)
· [Imported VlppOS.Windows.cpp](../../Import/Release/VlppOS.Windows.cpp).

## Proposal

Preserve the native result in the error returned or reported to callers. Cover
distinguishable response-send errors, and verify that the automation service can
include the actual Windows result in its request diagnostics.
