# FullControlTest modal automation interruptions

During Win8Skin verification under `/D2D /Hosted`, the `DocumentEditorSop`
runner stopped with `ElementNotAvailableException` after the Toolstrip editor's
UIA hyperlink route 0 saved `hyperlink-1-1.bin`. The file existed and contained
117,758 bytes; the automation service remained responsive and showed the next
**Load a GacUI Document** modal. The original exception stack was truncated by
the outer PowerShell error pipeline. The precise failing UIA call and root
cause therefore remain unconfirmed; this observation does not establish a skin
defect or a provider lifetime bug.

## Source findings

In
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs),
`PersistenceFile` logs the command only after `PersistenceCommand` returns.
The absence of the subsequent Load log, together with its visible modal, places
the likely interruption in post-invocation dialog discovery. In hosted mode,
`OwnedWindows` returns the root provider, and `FindNamed` searches its complete
descendant tree. A traversal crossing a disappearing popup or dialog is a
plausible explanation, not a demonstrated cause.

[GacUI/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationProvider.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationProvider.Windows.cpp)
returns `UIA_E_ELEMENTNOTAVAILABLE` when `WindowsUIAutomationProvider::Read`
finds a non-live node. Retirement and queued provider disconnection in
[GacUI/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationState.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationState.Windows.cpp)
are intentional lifetime protections. Their presence alone does not establish
incorrect retirement. The existing `ResponsiveDialog` harness helper already
tolerates an element disappearing during discovery.

## Verification workaround

The unfinished Load dialog was canceled and the SOP resumed from step 14 with
fresh UIA references. That first resume encountered a separate, confirmed
`file dialog completed` timeout: saving to the existing output path opened an
overwrite-confirmation modal that the first-run helper does not handle.

The temporary runner now prints the full exception before returning failure
and gives each resumed SOP a unique output directory, preserving earlier
artifacts while avoiding that additional overwrite prompt. The unfinished
dialogs are canceled before resuming. No skin, imported runtime, or upstream
source is modified, and no UIA provider retry has been added. These workarounds
do not by themselves establish that the resumed scenario passes; its assertions
must still complete.

## Proposed harness improvement

Preserve full exception stacks and distinguish command invocation from dialog
discovery in the log. If a recurrence confirms a stale element during bounded
dialog discovery, catch only `ElementNotAvailableException` in that lookup,
discard the failed lookup's references, and re-enumerate on the next poll within
the existing timeout. Prefer direct hosted-window children where appropriate.
Do not retry commands blindly or suppress failures from command execution or
document assertions. Keep a permanent unavailable root as a bounded failure.

Use a unique artifact directory for every resumed run. Add a harness regression
that closes a popup while discovering its newly opened modal, verifies exactly
one command invocation, and checks both successful re-enumeration and timeout
when the expected modal never appears. Test resumption with prior output files
present, preserving the original files and all document round-trip assertions.
