# Retained logical focus after composition changes

During Win8Skin verification in the long-running `/D2D /Hosted` showcase,
`PointRegression` passed its first short-press caret-equivalence check, then
failed `short press focuses the document unique reachable logical focus`.
Both the inline **Style** ribbon gallery's unnamed List and the editor's
Document reported `HasKeyboardFocus=true` and `IsOffscreen=false`. Fresh
provider queries confirmed both were live descendants of the same main window;
the automation-service snapshot contained no popup or modal window.

The retained evidence is `point-focus-observation.log` and
`point-focus-observation.json` in the temporary Win8Skin verification folder.
The List measured 288 by 79 pixels and the Document 1,160 by 452 pixels. This
was a duplicate logical-focus report, rather than an exception from a retired
provider. Its exact triggering operation in the preceding test sequence has
not been established.

## Source findings

`CheckFocus` in
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
requires the target to be the only reachable GacUI element reporting keyboard
focus. The provider's `WindowsUIAutomationNode::IsFocused` in
[GacUI/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationSemantic.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationSemantic.Windows.cpp)
uses `control->GetFocused()` for both these controls. The gallery has no special
selection-as-focus mapping, so this is not an expected selected-item report or
a reason to relax that assertion.

In
[GacUI/Source/Application/Controls/GuiBasicControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/Controls/GuiBasicControls.cpp),
`GuiControl::GetFocused` returns the retained `isFocused` flag.
`OnLostFocus` clears it and updates the template and `FocusedChanged` event.
In
[GacUI/Source/Application/GraphicsHost/GuiGraphicsHost.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Application/GraphicsHost/GuiGraphicsHost.cpp),
`SetFocusInternal` dispatches the old composition's `lostFocus`, but
`DisconnectCompositionInternal` instead clears a matching `focusedComposition`
pointer without dispatching that notification. A surviving control can thus
retain its flag after this detachment path.

Composition removal calls this disconnection path. Responsive ribbon view
changes also remove and reattach composition subtrees in
[GacUI/Source/Controls/ToolstripPackage/GuiRibbonControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ToolstripPackage/GuiRibbonControls.cpp).
These are concrete source paths worth testing, but they have not been traced
as the cause of the observed failure. Theme rebuilding already attempts to
restore the previously focused control; that restoration must be considered
when correcting disconnection behavior. The new skins retain DarkSkin's
gallery control structure and do not override its focus behavior.

## Verification workaround and proposed regression

Preserve the failed-run evidence, close the showcase normally, and run the
remaining point suite first in a fresh process with every assertion unchanged.
This isolates retained state from the preceding suite; a successful isolated
run would not erase the original failure or prove its trigger. Do not suppress
the gallery from focus enumeration or normalize its focus before asserting.

Review focus invalidation when a focused composition is detached: clear the
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
