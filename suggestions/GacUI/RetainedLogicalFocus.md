# Two live controls can report keyboard focus after composition changes

A ribbon gallery list and the editor document both reported keyboard focus in one live
window. The earlier action that left the gallery focused is unknown.

## Repro

In `FullControlTest /D2D /Hosted`, use Win8Skin and run the `PointRegression`
short-press caret check on **Control / Document Editor (Ribbon)** following other
showcase suites in the same process. Query all reachable UIA elements with
`HasKeyboardFocus` after the document receives the short press. This is the recorded
sequence for an intermittent failure.

During Win8Skin verification in the long-running `/D2D /Hosted` showcase,
`PointRegression` passed its first short-press caret-equivalence check, then
failed `short press focuses the document unique reachable logical focus`.
Both the inline **Style** ribbon gallery's unnamed List and the editor's
Document reported `HasKeyboardFocus=true` and `IsOffscreen=false`. Fresh
provider queries confirmed both were live descendants of the same main window. The
automation-service snapshot contained no popup or modal window.

The retained evidence is `point-focus-observation.log` and
`point-focus-observation.json` in the temporary Win8Skin verification folder.
The List measured 288 by 79 pixels and the Document 1,160 by 452 pixels.

A fresh process running the unchanged point suite first passed 2,479 assertions. The
earlier failure is preserved in `PointRegression-contaminated4044.log`.
[Win8 verification](../../doc/Win8SkinVerification.md#shared-runtime-issues-and-coverage-interpretation).

## Workaround

N/A

## Root Cause

The trigger in the observed run is unknown. `CheckFocus` requires a single reachable
logical focus owner. For both controls, `WindowsUIAutomationNode::IsFocused` reads
`control->GetFocused()`. This query exposes the gallery’s retained focus flag
independently of its selection.
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
·
[<GacUI-repo>/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationSemantic.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationSemantic.Windows.cpp).

`GuiControl::GetFocused` returns `isFocused`. `OnLostFocus` clears the flag, updates
the template and raises `FocusedChanged`. `SetFocusInternal` sends the old composition
its lost-focus notification. `DisconnectCompositionInternal` can clear the host’s
focused composition without sending that notification, leaving a surviving control
with its flag set.
[<GacUI-repo>/Source/Application/Controls/GuiBasicControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/Controls/GuiBasicControls.cpp)
·
[<GacUI-repo>/Source/Application/GraphicsHost/GuiGraphicsHost.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/GraphicsHost/GuiGraphicsHost.cpp).

Removing a composition uses this path. Responsive ribbon groups remove and reattach
subtrees, and retemplating can restore previous focus. These are possible paths to
investigate. No trace ties a particular detachment to the recorded duplicate focus.
[<GacUI-repo>/Source/Controls/ToolstripPackage/GuiRibbonControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ToolstripPackage/GuiRibbonControls.cpp).

## Proposal

When detaching a focused composition, clear the
surviving control's logical flag and send the corresponding notifications
before discarding the host's focus reference, with disposal and reentrancy
handled safely. If retemplating deliberately restores focus, restore exactly
one current attachment afterwards.

Add regressions that focus a ribbon gallery, refresh its theme or collapse and
expand its responsive group, then focus the document by mouse and short press.
Also test detaching and reattaching a focused surviving control directly.
Assert a single logical focus owner, matching template focus state and UIA
properties/events, and unchanged caret equivalence. Exercise DarkSkin and the
new skins, and verify that destroying a focused control remains safe.
