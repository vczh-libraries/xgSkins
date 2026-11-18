# FullControlTest single-line field shortcut routing

During Win7Skin verification, the Ribbon document editor's `Ctrl+A` shortcut
selected the central document even while the Search field had keyboard focus.
Typing into Search then inserted at its existing caret instead of replacing its
previous value. This is application command routing, independent of the skin.

The upstream
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
helper `EditorSetValue` assumes `Ctrl+A` selects the focused single-line field.
That assumption fails when Search already contains the marker from the earlier
SOP persistence check. The first six initially empty Icon Labels fields did not
expose the assumption.

For local verification, the temporary test adapter uses `Home`, `Shift+End`,
then typing to replace a single-line field through automation IO. UIA Value
operations remain a separate route. No upstream source or skin input behavior
was changed.

The showcase should limit its document-editing shortcuts to the central editor
when it owns focus, allowing other editors to handle their own selection and
clipboard keys. The regression helper should also test replacement of existing
text in Search, rather than relying on a fresh empty field.

## WinXPSkin Window fixture

The WinXPSkin Window run in process 27980 passed move/resize checks, then timed
out clearing its Toolstrip document with Ctrl+A followed by Delete. A fresh
provider reported the original content, focus true and no selection. This does
not establish the same cause as the earlier Search-field routing issue.
[GacUI/Test/Resources/App/FullControlTest/DocumentEditorBase.xml](https://github.com/vczh-libraries/GacUI/blob/master/Test/Resources/App/FullControlTest/DocumentEditorBase.xml)
assigns Ctrl+A to `commandSelect`; `commandDelete` has no Delete-key shortcut.
Those declarations alone do not identify which input step failed.

The temporary adapter selected the complete TextPattern document range,
verified exact selection, sent Delete and verified empty text before proceeding.
Both assertions passed, followed by the menu/formatting/modal/subwindow checks.
No skin or upstream source changed. This is an explicit fixture setup route,
not successful verification of the original Ctrl+A sequence. Its logs are
`%TEMP%/xgskins-winxp-Window.log` and
`%TEMP%/xgskins-winxp-WindowRemaining.log`; the later palette-readiness stop is
recorded separately in [WinXPSkinVerification.md](../doc/WinXPSkinVerification.md).

A focused regression should capture selection after Ctrl+A and after Delete
separately, along with logical focus and the receiving control, before assigning
a shortcut-routing cause.
