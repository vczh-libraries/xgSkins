# A failed automation tree response terminates the showcase

A failed HTTP response from the Windows automation service terminated FullControlTest
during the Raw Clock scenario.

## Repro

In `FullControlTest /D2D /Hosted`, run **Misc / Raw Clock** with WinXPSkin, check its
data, timer and bounds, switch to DarkSkin, then reopen Raw Clock through the
automation service. In process 27980 the `Controls` GET in `OpenRawClock` exceeded the
test client’s 15-second deadline. The process displayed a hidden, owned Microsoft
Visual C++ Runtime Library abort dialog before the point-input tests began. The timing
failure was observed once.

After the owned runtime dialog was dismissed with Abort, CDB recorded exit code 3 at
2026-11-18 11:13:41.567 PST. This fatal run supplies no normal-exit or leak-audit
result. Debugger evidence is retained in
`xgskins-winxp-runtime-dialog.json`, `xgskins-winxp-runtime-abort.log` and
`xgskins-winxp-progress-debugger.log` under the Windows temporary directory.

The client evidence is `xgskins-winxp-RawClock.log` and `RawClock-20261118-190629-698`
under the Windows temporary directory.
[XP verification](../../doc/WinXPSkinVerification.md#raw-clock-automation-response-failure).

## Workaround

The temporary client allows 60 seconds per request. After the theme switch it waits up
to 30 seconds, polling every 300 milliseconds for the previous palette provider to
retire and the new Window Manager to show DarkSkin, before requesting the next tree.
With this mitigation process 25932 completed 160 Raw Clock assertions and restored XP.
The log is `xgskins-winxp-final-RawClock.log` and the artifact directory is
`RawClock-20261118-192620-440`. This test result leaves the server failure policy
open.

## Root Cause

The debugger located the main thread in the catch-all `std::terminate` path of
`HttpAutomationService::DumpTreeAsync`. It queues both tree generation and
`SendResponseUtf8` on the main thread. The captured `vl::Error` read
`HttpSendHttpResponse failed for responding UTF-8 body.` The response send failed. The
native result, the reason for the timeout and the role of client cancellation remain
unknown.
[<GacUI-repo>/Source/Utilities/AutomationService/Windows/WindowsAutomationService.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Utilities/AutomationService/Windows/WindowsAutomationService.Windows.cpp)
· [Imported GacUI.Windows.cpp](../../Import/Release/GacUI.Windows.cpp) ·
[VlppOS diagnostic issue](../VlppOS/HttpResponseErrorCode.md).

## Proposal

Distinguish failures to generate the tree from failures to send it. Record the request
ID, kind, response size, native result and timing. Define how the service handles
disconnected or canceled requests under its fail-fast policy. Exercise delayed
main-thread service and shutdown with a pending request, checking diagnostics and
request lifetime.
