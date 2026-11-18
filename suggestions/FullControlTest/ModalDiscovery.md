# The editor test can lose a UIA element while discovering a new modal

A Win8Skin hyperlink save completed before the runner lost its UIA element while entering the next operation.

## Repro

In `FullControlTest /D2D /Hosted`, run the `DocumentEditorSop` UIA hyperlink route 0
in **Control / Document Editor (Toolstrip)**. Save the hyperlink document, then load
it again. In the recorded interruption `hyperlink-1-1.bin` existed at 117,758 bytes
and the service showed the **Load a GacUI Document** modal. The runner raised
`ElementNotAvailableException`. Its truncated PowerShell stack did not identify the
failing UIA call.
[Win8 verification](../../doc/Win8SkinVerification.md#document-editor-sop-interruption).

## Workaround

Cancel the unfinished Load dialog, reacquire UIA references and resume at step 14. The
temporary runner preserves the full exception stack and uses a fresh output directory
for the resumed run. It added no provider retry.
[Separate overwrite prompt](ResumedSaveOverwrite.md).

## Root Cause

In
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs),
`PersistenceFile` logs the command only after `PersistenceCommand` returns.
The absence of the subsequent Load log, together with its visible modal, places
the likely interruption in post-invocation dialog discovery. In hosted mode,
`OwnedWindows` returns the root provider, and `FindNamed` searches its complete
descendant tree. A traversal crossing a disappearing popup or dialog is a
plausible explanation, not a demonstrated cause.

[<GacUI-repo>/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationProvider.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationProvider.Windows.cpp)
returns `UIA_E_ELEMENTNOTAVAILABLE` when `WindowsUIAutomationProvider::Read`
finds a non-live node. Retirement and queued provider disconnection in
[<GacUI-repo>/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationState.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationState.Windows.cpp)
are intentional lifetime protections. Their presence alone does not establish
incorrect retirement. The existing `ResponsiveDialog` harness helper already
tolerates an element disappearing during discovery.

## Proposal

Preserve full exception stacks and log command invocation separately from dialog
discovery. If another trace confirms retirement during lookup, handle
`ElementNotAvailableException` within that bounded lookup, discard its references and
re-enumerate. The existing timeout should still report a missing root or dialog.

Exercise a popup closing as its new modal appears, successful rediscovery, and a
permanently missing modal. Verify exactly one command invocation and preserve the
command and document assertions.
