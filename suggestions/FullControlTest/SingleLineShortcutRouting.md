# Ctrl+A in the ribbon Search field selects the document

The showcase routes the Select All shortcut to the central document while the ribbon
Search field has keyboard focus.

## Repro

In `FullControlTest /D2D /Hosted`, use **Control / Document Editor (Ribbon)**. Enter a
marker in Search, focus the field, press Ctrl+A and type its replacement. Inspect the
Search value and the selection in the central document.

During Win7Skin verification, the Ribbon document editor's `Ctrl+A` shortcut
selected the central document even while the Search field had keyboard focus.
Typing into Search then inserted at its existing caret instead of replacing its
previous value. This is application command routing, independent of the skin.

## Workaround

For local verification, the temporary test adapter uses `Home`, `Shift+End`,
then typing to replace a single-line field through automation IO. UIA Value
operations remain a separate route. No upstream source or skin input behavior
was changed.

## Root Cause

The showcase binds Ctrl+A to its document-selection command. The upstream
`EditorSetValue` helper assumes the shortcut selects the currently focused single-line
field. The first six Icon Labels fields began empty, which masked that assumption.
Search already contained the earlier persistence marker.
[Document-editor command bindings](../../Test/FullControlTest/UI/FullControlTest/DocumentEditorBase.xml)
·
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).

## Proposal

The showcase should limit its document-editing shortcuts to the central editor
when it owns focus, allowing other editors to handle their own selection and
clipboard keys. The regression helper should also test replacement of existing
text in Search, rather than relying on a fresh empty field.
