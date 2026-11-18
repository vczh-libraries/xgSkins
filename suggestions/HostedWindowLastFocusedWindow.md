# Hosted window focus restoration after destruction

During the final Win7Skin Debug x64 `/D2D /Hosted` verification on 2026-11-18,
the focused Text UIA suite stopped after the Walk, List and Grid suites had
passed. A native focus notification triggered an access violation. The debugger
stack was:

```text
GuiHostedController::GotFocus
Window<GuiHostedWindow*>::Activate
Window<GuiHostedWindow*>::BringToFront
List<Window<GuiHostedWindow*>*>::Contains / IndexOf
```

`GuiHostedController::lastFocusedWindow` pointed to freed/corrupt storage, while
`mainWindow` still pointed to a valid hosted window. The failure was in focus
restoration, not a skin template callback. UIA reported ElementNotAvailable
because the application had stopped in the debugger.

The cause is visible in
[GacUI/Source/PlatformProviders/Hosted/GuiHostedController.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/PlatformProviders/Hosted/GuiHostedController.cpp#L1059).
The imported equivalent is `Import/Release/GacUI.cpp`, line 34987:

```cpp
if (hostedWindow == lastFocusedWindow) enteringWindow = nullptr;
```

`DestroyNativeWindow` should clear `lastFocusedWindow` there instead. Add a
regression that loses native focus while a hosted child is active, destroys
that child, then restores native focus. The controller must activate a live
window or safely fall back to the main window, without retaining the destroyed
child.

Upstream and imported sources are intentionally unchanged. For verification,
the crashed process was terminated after recording the stack. Remaining suites
run in a fresh process, starting with Text before popup/dialog lifecycle tests
and without additional native foreground probes. This is test isolation, not
a runtime repair; the underlying hosted-focus defect remains in the imported
library. The earlier full editor/gallery run exited normally with code 0 and
no CRT leak report.
