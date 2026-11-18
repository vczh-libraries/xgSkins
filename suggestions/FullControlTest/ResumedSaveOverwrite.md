# A resumed editor test can block on an overwrite prompt

Resuming the document-editor SOP in its original output directory can open a
confirmation that the first-run helper does not handle.

## Repro

In `FullControlTest /D2D /Hosted`, use the Toolstrip editor’s UIA hyperlink save
route, then resume `DocumentEditorSop` at step 14 using the same output directory.
Saving to the existing artifact opens an overwrite confirmation. The helper times out
at `file dialog completed`.
[Win8 verification](../../doc/Win8SkinVerification.md#document-editor-sop-interruption).

## Workaround

Cancel the outstanding dialogs and give each resumed run its own output directory.
This preserves the first run’s artifacts. The isolated Win8 continuation passed 2,095
assertions.

## Root Cause

The first-run save helper expects the file dialog to close after the save action. A
pre-existing destination introduces an additional modal. This was confirmed separately
from the earlier UIA discovery interruption.
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
· [UIA modal discovery](ModalDiscovery.md).

## Proposal

Use unique artifact directories for resumed runs. Cover a pre-existing output file
while preserving the original, verifying a single save invocation and retaining the
document round-trip assertions.
