# A failed automation tree response terminates the showcase

A failed HTTP response from the Windows automation service terminated FullControlTest
during the Raw Clock scenario.

## Repro

In `FullControlTest /D2D /Hosted`, run **Misc / Raw Clock** with WinXPSkin, check its
data, timer and bounds, switch to DarkSkin, then reopen Raw Clock through the
automation service. In process 27980 the `Controls` GET in `OpenRawClock` exceeded the
test client’s 15-second deadline. The process displayed a hidden, owned Microsoft
Visual C++ Runtime Library abort dialog before the point-input tests began.

After the owned runtime dialog was dismissed with Abort, CDB recorded exit code 3 at
2026-11-18 11:13:41.567 PST. This fatal run supplies no normal-exit or leak-audit
result. Debugger evidence is retained in
`xgskins-winxp-runtime-dialog.json`, `xgskins-winxp-runtime-abort.log` and
`xgskins-winxp-progress-debugger.log` under the Windows temporary directory.

The client evidence is `xgskins-winxp-RawClock.log` and `RawClock-20261118-190629-698`
under the Windows temporary directory.
[XP verification](../../doc/WinXPSkinVerification.md#raw-clock-automation-response-failure).

To reproduce the delay on the November 18 source, build commit `5c8a5e4` in
Debug x64. Use a 1250 × 900 hosted window and a 15-second request deadline.
With Raw Clock showing under XP, register Windows UI Automation handlers on the
root subtree for structure changes, changes to Name/IsSelected/ToggleState, and
text and text-selection changes. Keep the handlers registered. Through HTTP IO,
click **Window Manager**, then **DarkSkin**. Immediately fetch `Controls` and
run the original `OpenRawClock` polling loop. The first GET can return the old
tree before the deferred skin switch. The next GET times out. The historical
test helper contains the polling loop and the four event registrations.
[GacUI test helper](https://github.com/vczh-libraries/GacUI/blob/1b5ef89f6/Test/UIA_CppTest_Shared.cs)

## Workaround

When the test has finished observing UI Automation events, remove its subtree
handlers before changing the skin. Five replays on the same process then served
the post-refresh tree within the original 15-second deadline.

The November 18 verification used a 60-second client timeout and waited for the
previous palette provider to retire and the new Window Manager to show DarkSkin
before requesting the next tree. Process 25932 completed 160 Raw Clock assertions and restored XP.
The log is `xgskins-winxp-final-RawClock.log` and the artifact directory is
`RawClock-20261118-192620-440`. This test result leaves the server failure policy
open.

## Root Cause

The HTTP worker accepts the GET and queues `HttpAutomationService::DumpTreeAsync`’s
callback on the UI thread. The skin click has already queued `RefreshThemes` on
that thread. It walks the registered windows and recursively rebuilds control
templates. The tree callback has to wait until that work finishes.
[Showcase skin selection](../../Test/FullControlTest/UI/FullControlTest/Resource.xml)
· [Imported GacUI.cpp](../../Import/Release/GacUI.cpp)

With UI Automation observation active, removing a composition synchronously calls
`WindowsUIAutomationContext::RetireSubtree`. For each composition it scans the
entire list of bounds hooks. For each associated control it also scans the list
of automation nodes. It repeats those scans for every child of the detached
subtree. In the 37.32-second refresh, 83 of 97 UI-thread stack samples were in
`RetireSubtree`, including 30 of the 39 samples taken before the deadline.
The refresh made 3,402 template rebuild calls.
[UI Automation removal observer and retirement loops](https://github.com/vczh-libraries/GacUI/blob/1b5ef89f6/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationState.Windows.cpp)

The following timings are for the individual timed-out GET in three November 20
replays with the four handlers active. The UI queue wait includes the theme
refresh. The native send column measures the Windows API call after UTF-8 encoding.

| Historical Debug x64 build | UI queue wait | Generate tree | Encode and prepare send | Native send |
| --- | ---: | ---: | ---: | ---: |
| Under CDB | 37.341 s | 39.55 ms | 9.45 ms | 0.34 ms |
| Outside CDB | 20.809 s | 8.45 ms | 9.59 ms | 0.23 ms |
| Under CDB, separate passive UI Automation client | 31.577 s | 27.52 ms | 9.93 ms | 0.22 ms |

For the last comparison, both showcase editors held the historical document
fixture, and three modeless child windows had been opened and closed. After
the earlier UI Automation client exited, five consecutive XP-to-Dark runs
waited 2.18–2.83 seconds in the UI queue. Adding a passive observer to the same
process took that wait to 31.577 seconds. The Raw Clock client issued the same
requests and the tree still contained 149,324 characters. The observed refresh
alone took 31.566 seconds.

During the first stall an independent GET to an unknown route returned HTTP 404
in 1.2 ms. In all three replays the timed-out client had already abandoned its
request when `HttpSendHttpResponse` returned Windows error 64
(`ERROR_NETNAME_DELETED`), with zero bytes sent. VlppOS threw its fixed-message
exception and the GacUI callback called `std::terminate`. The per-request traces
are `%TEMP%/xgskins-http-trace-23364.tsv`, `%TEMP%/xgskins-http-trace-25556.tsv`
and `%TEMP%/xgskins-http-trace-6900.tsv`.
The stack samples and client logs are in `%TEMP%/xgskins-http-15s-20261120/`.
[<GacUI-repo>/Source/Utilities/AutomationService/Windows/WindowsAutomationService.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Utilities/AutomationService/Windows/WindowsAutomationService.Windows.cpp)
· [Imported GacUI.Windows.cpp](../../Import/Release/GacUI.Windows.cpp) ·
[VlppOS diagnostic issue](../VlppOS/HttpResponseErrorCode.md).

For the November 18 incident, CDB first sampled PID 27980 after it had entered
the abort dialog. That capture shows the send exception and a response length
of 149,324 characters. Replays using the original client sequence returned a
post-refresh DarkSkin tree of that length. The original artifacts do not record
the UI stack during the deadline, the active subscriptions or the native send
result. The Raw Clock client itself registered no subtree handlers during this step.

## Proposal

Index bounds hooks by composition and automation nodes by associated control so
retiring a subtree visits the affected entries directly. Verify the XP-to-Dark
switch with active UI Automation clients and a 15-second HTTP deadline.

Distinguish time queued for the UI thread, tree generation and the native send.
Record the request ID, kind, response size and native result. Define how the service handles
disconnected or canceled requests under its fail-fast policy. Exercise delayed
main-thread service and shutdown with a pending request, checking diagnostics and
request lifetime.
