# Private document bytes differ after edit, theme replacement and undo

The WinXPSkin `DocumentExchange` Ribbon sequence loaded the upstream
[GacUI/Test/TestDocument.bin](https://github.com/vczh-libraries/GacUI/blob/master/Test/TestDocument.bin),
appended and selected `§`, switched from
WinXPSkin to DarkSkin, and undid the insertion. The existing UIA assertions
passed for loaded text, exact edited text and selection after replacement,
and exact original text after undo. Saving then failed the upstream helper's
whole-file byte comparison. This is a serialization failure, not a complete
pass for document preservation.

The original file is 117,713 bytes; the saved `editor-0.bin` is 117,679 bytes.
An independent binary comparison found XML starting at byte 44 in both files,
shrinking from 1,689 to 1,655 UTF-8 bytes. The only XML change is in the final
paragraph: `<font face="Segoe UI" size="14" color="#70E6CC">` becomes
`<font size="14" color="#70E6CC">`, and its `<b->` and `<i->` wrappers disappear.
All other XML, including paragraph alignment, text, named styles, image
references and image geometry, is identical. The 115,980 bytes after `</Doc>`
are identical; the prefix changes only in the XML length fields.

The machine-local evidence is `xgskins-winxp-DocumentExchange.log` and
`xgskins-verification/WinXPSkin/DocumentExchange-20261118-181702-414/Exchange-27980/editor-0.bin`
under the Windows temporary directory. The failing sequence is
`DocumentExchange` in
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).
There are no intermediate serialized checkpoints isolating loading, typing,
theme replacement and undo. Text assertions and unchanged embedded bytes do
not establish complete resolved-format equivalence. Removing an explicit
value also changes inheritance under a different default style.

The separate Toolstrip sequence preserved edited text and selection across
DarkSkin to WinXPSkin, then timed out in its original ten-second undo wait.
A later read found the exact original text, including image placeholders;
the saved `late-undo-expected.txt` and `late-undo-actual.txt` are identical
257-byte files. The continuation did not replay editing, theme replacement,
loading or undo. Its subsequent strict save assertion also failed:
`editor-1.bin` is byte-for-byte identical to the Ribbon's 117,679-byte save,
with the same XML simplification and unchanged resource suffix. The timing
failure remains a separate failed assertion. Evidence is in
`xgskins-winxp-DocumentExchangeRemaining.log`,
`xgskins-winxp-DocumentExchangeFinish.log` and
`xgskins-verification/WinXPSkin/DocumentExchangeFinish-20261118-182922-876/Exchange-27980/editor-1.bin`
under the Windows temporary directory; the two text files are in that run's
parent output directory.

## Relevant upstream behavior

`GuiDocumentCommonInterface::EditTextInternal` captures only the edited range
for undo in
[GacUI/Source/Controls/TextEditorPackage/GuiDocumentCommonInterface.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/TextEditorPackage/GuiDocumentCommonInterface.cpp).
`DocumentModel::EditText` calls `EditRunNoCopy`, which normalizes the entire
affected paragraph using `ClearUnnecessaryRun` in
[GacUI/Source/Resources/GuiDocument_Edit.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Resources/GuiDocument_Edit.cpp).
Its `CompressStyleRunVisitor` explicitly clears face, bold and italic when
they equal the currently resolved inherited values in
[GacUI/Source/Resources/GuiDocumentEditor_ClearUnnecessaryRun.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Resources/GuiDocumentEditor_ClearUnnecessaryRun.cpp).
Undo replaces the edited range through `EditRun`, entering that normalization
path again, in
[GacUI/Source/Controls/TextEditorPackage/EditorCallback/GuiTextUndoRedo.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/TextEditorPackage/EditorCallback/GuiTextUndoRedo.cpp).
This explains a plausible mechanism for the observed simplification; it does
not prove the exact operation responsible in this run.

## Verification continuation and upstream proposal

Keep both exact-byte failures, the Toolstrip timing failure and their
artifacts. The unfinished Toolstrip work was run separately with the same
strict assertion. Continue unrelated skin verification without describing
this scenario as passing. Semantic checks may be recorded separately for text,
selection, resolved formatting, alignment and images. Do not silently remove
style wrappers from the expected file or treat text equality as formatting
equality. No application, skin or upstream source workaround is applied.

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
