# The Window fixture can time out clearing the Toolstrip document

The WinXPSkin Window scenario timed out after Ctrl+A and Delete with the original document still present.

## Repro

In `FullControlTest /D2D /Hosted`, run the WinXPSkin `Window` scenario through its
move and resize checks. Focus the Toolstrip editor’s populated document, send Ctrl+A
followed by Delete and inspect the text, focus and selection. In process 27980 a fresh
provider returned the original text, focus true and no selection.

The original and resumed logs are `%TEMP%/xgskins-winxp-Window.log` and
`%TEMP%/xgskins-winxp-WindowRemaining.log`.
[XP verification](../../doc/WinXPSkinVerification.md#window-fixture-and-refresh-continuation).

## Workaround

For fixture setup, select the complete UIA `TextPattern` document range, verify the
exact selection, send Delete once and verify empty text. The checks then continued
through the menu, formatting, modal and subwindow operations.

## Root Cause

Unknown. The showcase assigns Ctrl+A to `commandSelect`. Its `commandDelete` has no
Delete-key shortcut. The recorded run did not establish whether selection or deletion
failed, or connect it to the ribbon Search behavior.
[<GacUI-repo>/Test/Resources/App/FullControlTest/DocumentEditorBase.xml](https://github.com/vczh-libraries/GacUI/blob/master/Test/Resources/App/FullControlTest/DocumentEditorBase.xml)
· [Search-field shortcut routing](SingleLineShortcutRouting.md).

## Proposal

A focused regression should capture selection after Ctrl+A and after Delete
separately, along with logical focus and the receiving control, before assigning
a shortcut-routing cause.
