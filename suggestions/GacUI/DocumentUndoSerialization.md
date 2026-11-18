# Private document bytes differ after edit, theme replacement and undo

Undo restores the document’s text in both showcase editors, while a subsequent
private-format save omits the explicit font face, bold and italic settings in the
final paragraph.

## Repro

Use `FullControlTest /D2D /Hosted` and the `DocumentExchange` scenario. In
**Control / Document Editor (Ribbon)**, load the upstream sample in private format,
move to the end, append and select `§`, switch from WinXPSkin to DarkSkin, undo and
save to a new private-format file. Repeat with the Toolstrip editor in the reverse
skin order. Compare the entire saved file and the restored text.
[<GacUI-repo>/Test/TestDocument.bin](https://github.com/vczh-libraries/GacUI/blob/master/Test/TestDocument.bin).

The original file is 117,713 bytes and the saved `editor-0.bin` is 117,679 bytes.
An independent binary comparison found XML starting at byte 44 in both files,
shrinking from 1,689 to 1,655 UTF-8 bytes. The only XML change is in the final
paragraph. Its `<font face="Segoe UI" size="14" color="#70E6CC">` becomes
`<font size="14" color="#70E6CC">`, and its `<b->` and `<i->` wrappers disappear.
All other XML, including paragraph alignment, text, named styles, image
references and image geometry, is identical. The 115,980 bytes after `</Doc>`
are identical. The prefix changes only in the XML length fields.

The machine-local evidence is `xgskins-winxp-DocumentExchange.log` and
`xgskins-verification/WinXPSkin/DocumentExchange-20261118-181702-414/Exchange-27980/editor-0.bin`
under the Windows temporary directory. The failing sequence is
`DocumentExchange` in
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).
There are no intermediate serialized checkpoints isolating loading, typing,
theme replacement and undo. Text assertions and unchanged embedded bytes do
not establish complete resolved-format equivalence. Removing an explicit
value also changes inheritance under a different default style.

The separate Toolstrip sequence preserved edited text and selection across
DarkSkin to WinXPSkin, then timed out in its original ten-second undo wait.
A later read found the exact original text, including image placeholders. The saved
`late-undo-expected.txt` and `late-undo-actual.txt` are identical
257-byte files. The continuation did not replay editing, theme replacement,
loading or undo. Its subsequent strict save assertion also failed. The `editor-1.bin`
file is byte-for-byte identical to the Ribbon's 117,679-byte save,
with the same XML simplification and unchanged resource suffix. The timing
failure remains a separate failed assertion. Evidence is in
`xgskins-winxp-DocumentExchangeRemaining.log`,
`xgskins-winxp-DocumentExchangeFinish.log` and
`xgskins-verification/WinXPSkin/DocumentExchangeFinish-20261118-182922-876/Exchange-27980/editor-1.bin`
under the Windows temporary directory. The two text files are in that run's
parent output directory. The [verification record](../../doc/WinXPSkinVerification.md#document-exchange-byte-mismatch)
includes the independent binary comparison.

## Workaround

N/A

## Root Cause

`GuiDocumentCommonInterface::EditTextInternal` captures only the edited range
for undo in
[<GacUI-repo>/Source/Controls/TextEditorPackage/GuiDocumentCommonInterface.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/TextEditorPackage/GuiDocumentCommonInterface.cpp).
`DocumentModel::EditText` calls `EditRunNoCopy`, which normalizes the entire
affected paragraph using `ClearUnnecessaryRun` in
[<GacUI-repo>/Source/Resources/GuiDocument_Edit.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Resources/GuiDocument_Edit.cpp).
Its `CompressStyleRunVisitor` explicitly clears face, bold and italic when
they equal the currently resolved inherited values in
[<GacUI-repo>/Source/Resources/GuiDocumentEditor_ClearUnnecessaryRun.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Resources/GuiDocumentEditor_ClearUnnecessaryRun.cpp).
Undo replaces the edited range through `EditRun`, entering that normalization
path again, in
[<GacUI-repo>/Source/Controls/TextEditorPackage/EditorCallback/GuiTextUndoRedo.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/TextEditorPackage/EditorCallback/GuiTextUndoRedo.cpp).
This explains a plausible mechanism for the observed simplification. The operation
responsible in this run remains unconfirmed.

## Proposal

Add upstream checkpoints for load/save without edits, append/save,
append/undo/save without replacement, and append/replacement/undo/save in both
editors. Compare explicit model properties as well as resolved properties,
including reloading with different defaults. If undo must restore the exact
model, preserve the affected paragraph's pre-normalization structure or make
normalization part of the undo record. If canonical serialization is the
contract instead, define a stable normalization that preserves intended
inheritance, then test canonical bytes and semantic invariants separately.
The current whole-file assertion should not be weakened until that contract
and the missing formatting checks are established.
