# Preserve diagnostics for automation HTTP response failures

The WinXPSkin Raw Clock run in PID 27980 passed its initial data, timer and
bounds checks. After the XP-to-DarkSkin theme switch, a `Controls` GET from
`OpenRawClock` exceeded the temporary client's 15-second request timeout.
The process displayed an owned, hidden Microsoft Visual C++ Runtime Library
abort dialog. This failed run does not provide a clean-exit or leak-audit
result. No point-input group had started.

After the exact owned Abort button was revalidated, one bounded posted click
dismissed the dialog. CDB recorded process exit code 3 at
2026-11-18 11:13:41.567 PST. This was deliberate native runtime-error
termination, not the application's normal Exit path. Evidence is retained in
`xgskins-winxp-runtime-dialog.json`, `xgskins-winxp-runtime-abort.log` and
`xgskins-winxp-progress-debugger.log` under the Windows temporary directory.

CDB placed the main thread in `HttpAutomationService::DumpTreeAsync`'s
catch-all `std::terminate` path, after `SendResponseUtf8`. Recovering the active
exception object identified `vl::Error` with the exact description:
`HttpSendHttpResponse failed for responding UTF-8 body.` This proves a failed
response send. The underlying Windows result was not recovered. It does not
prove that client cancellation caused the failure, why the request exceeded
15 seconds, or that the skin or document renderer was responsible.

The corresponding implementation is
[GacUI/Source/Utilities/AutomationService/Windows/WindowsAutomationService.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Utilities/AutomationService/Windows/WindowsAutomationService.Windows.cpp).
`DumpTreeAsync` queues tree generation and the response send on the main
thread, then terminates on any exception. In
[VlppOS/Source/InterProcess/Windows/HttpServerApi.Windows.cpp](https://github.com/vczh-libraries/VlppOS/blob/master/Source/InterProcess/Windows/HttpServerApi.Windows.cpp),
`SendResponse` returns the `HttpSendHttpResponse` result, but
`SendResponseUtf8` uses the same `CHECK_ERROR` message for every nonzero value.
The imported build locations are
[GacUI.Windows.cpp](../Import/Release/GacUI.Windows.cpp) at lines 14766–14770 and
[VlppOS.Windows.cpp](../Import/Release/VlppOS.Windows.cpp) at lines 5987–5990.
Client evidence is `xgskins-winxp-RawClock.log` and the
`RawClock-20261118-190629-698` artifact directory under the Windows temporary
directory.

The temporary verification clients now use bounded 60-second request windows.
After Raw Clock's theme replacement, the adapter waits for the previous
palette provider to retire, reacquires the UIA root and requires a fresh
Window Manager page with DarkSkin selected before requesting another tree.
Readiness has a 30-second bound with 300-millisecond gaps. On fresh PID 25932,
Raw Clock subsequently passed 160 assertions with these adaptations, the
helper exited normally, and XP was restored. The log confirms the readiness
barrier before the next Controls dump. Evidence is
`xgskins-winxp-final-RawClock.log` and `RawClock-20261118-192620-440` under the
Windows temporary directory. This successful continuation does not establish
the original timeout's cause, a server fix or a normal application-exit/leak
audit. The prior fatal run remains failed. No skin, application or upstream
source workaround is applied.

Upstream should preserve the Windows error value, request ID, request kind,
response size and timing before failing. Distinguish tree-generation failures
from response-send failures in diagnostics. Define an explicit policy for
disconnected or canceled requests under the existing fail-fast contract,
rather than silently swallowing exceptions. Regression tests should cover a
client disconnect while a tree request is queued or being generated, delayed
main-thread service, and service shutdown with pending requests. Tests must
verify the chosen failure policy, diagnostic details and request lifetime.
