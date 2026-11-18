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
