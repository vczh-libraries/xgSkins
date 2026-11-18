# Hosted window focus restoration retains a destroyed window

The hosted controller attempted to restore focus through a window it had already destroyed.

## Repro

The recorded Debug x64 `FullControlTest /D2D /Hosted` session used Win7Skin. Run the
normal Walk, List, Grid and Text UIA suites in that order. During the Text suite’s
`ValuePattern.SetValue` check, a native focus notification stopped the process. The
debugger showed this stack.

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

For verification, the remaining suites ran in a fresh process with Text first and
without additional native foreground probes. The earlier full editor/gallery run had
exited with code 0 and no CRT leak report.
[Win7 verification](../../doc/Win7SkinVerification.md#upstream-focus-failure).

## Workaround

N/A

## Root Cause

In the affected revision, `DestroyNativeWindow` clears `enteringWindow` when the
destroyed window equals `lastFocusedWindow`. The controller’s saved focus target
therefore outlives that window. The imported source used by the failing build
contained this assignment at line 34987.
[<GacUI-repo>/Source/PlatformProviders/Hosted/GuiHostedController.cpp](https://github.com/vczh-libraries/GacUI/blob/450defad037a0dc6c0f13f9bc2aa7ab882bb1be6/Source/PlatformProviders/Hosted/GuiHostedController.cpp#L1059)
· [Imported GacUI.cpp](../../Import/Release/GacUI.cpp).

## Proposal

Clear `lastFocusedWindow` when its window is destroyed. Cover focus restoration during
the hosted-child lifecycle and require the controller to choose a live window, with
the main window as a fallback.
