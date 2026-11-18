# Disabled document editors retain their enabled foreground

WinXPSkin can change a disabled editor’s fill and border. The default document text
continues to use the enabled foreground.

## Repro

In `FullControlTest /D2D /Hosted`, select WinXPSkin and open
**Control / TextBox / TextBox**. Focus the single-line editor containing “Archer”.
Read its UI Automation (UIA) `TextPattern` foreground and inspect the fill and border
in the `Controls` tree. Press Ctrl+Q to open the showcase modal and repeat the
readings on its disabled owner.

The field’s fill changes from white to `#EBEBE4` and its border stays `#7F9DB9`. UIA
reports black (`0`) in both states. The original `XpConsumers-20261118-183009-527`
snapshots recorded the enabled, focused and modal-disabled states. A subsequent run
reproduced the measurements and captured the same area in both states.

**Enabled editor**

![Enabled XP editor with “Archer” in black on white](DisabledDocumentForeground_1.png)

**Editor disabled by the modal**

![Disabled XP editor with “Archer” still dark while the surrounding tab captions are gray](DisabledDocumentForeground_2.png)

## Workaround

N/A

## Root Cause

`GuiDocumentLabelTemplate` and `GuiDocumentViewerTemplate` expose `BaselineDocument`
and `CaretColor`. The controls consume the baseline when installing the template and
do not subscribe to `BaselineDocumentChanged`. The disabled-state handler updates
editable and focus attributes.
[<GacUI-repo>/Source/Controls/Templates/GuiControlTemplates.h](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/Templates/GuiControlTemplates.h)
·
[<GacUI-repo>/Source/Controls/TextEditorPackage/GuiDocumentViewer.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/TextEditorPackage/GuiDocumentViewer.cpp)
·
[<GacUI-repo>/Source/Controls/TextEditorPackage/GuiDocumentCommonInterface.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/TextEditorPackage/GuiDocumentCommonInterface.cpp).

`SetPropertiesVisitor` passes resolved run colors to `IGuiGraphicsParagraph::SetColor`
and handles selection in a separate pass. Neither receives an enabled-state input. UIA
also reads the resolved document color. The default consequently stays black when XP
calls for `#A1A192`.
[<GacUI-repo>/Source/GraphicsElement/GuiGraphicsDocumentRenderer_SetPropertiesVisitor.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/GraphicsElement/GuiGraphicsDocumentRenderer_SetPropertiesVisitor.cpp)
·
[<GacUI-repo>/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationText.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationText.Windows.cpp).

`MergeBaselineStyle` copies values into new style objects. Changing the template
baseline alone cannot update the installed styles. Reinstalling a template or
rewriting document runs would disturb document state.
[<GacUI-repo>/Source/Resources/GuiDocument.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Resources/GuiDocument.cpp).

## Proposal

Add an optional disabled foreground property to document templates and carry
it to the renderer as transient paint state. Define whether it affects only
default-colored text or all disabled text, and how selection is drawn. Update
the necessary paint caches on enabled-state changes without changing stored
default styles, author formatting, serialized bytes, selection or undo/redo
history. Align UIA's reported foreground with the chosen rendering contract.
Regression coverage should include plain and explicitly colored text,
selection, repeated disable/enable, theme replacement, unchanged private saves
and retained undo history. This lets skins request XP gray while preserving
the document model and restoring author colors on re-enable.
