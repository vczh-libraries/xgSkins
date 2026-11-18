# Disabled document foreground needs a rendering property

WinXPSkin changes disabled editor fill from white to `#EBEBE4` and retains the
`#7F9DB9` border. Its document baseline remains black. The saved
`XpConsumers-20261118-183009-527` snapshots and UIA flags establish focused,
enabled and modal-disabled editor states; UIA TextPattern foreground returned
black (`0`) in both states. Composition snapshots confirm the fill and border,
but do not expose rasterized document text. No native raster comparison was
available for this check.

Source inspection confirms a styling limitation rather than only missing UIA
evidence. `GuiDocumentLabelTemplate` and `GuiDocumentViewerTemplate` expose
`BaselineDocument` and `CaretColor`, but no disabled foreground property in
[GacUI/Source/Controls/Templates/GuiControlTemplates.h](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/Templates/GuiControlTemplates.h).
The controls read the baseline during template installation in
[GacUI/Source/Controls/TextEditorPackage/GuiDocumentViewer.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/TextEditorPackage/GuiDocumentViewer.cpp).
They do not subscribe to `BaselineDocumentChanged`. The disabled-state handler
only updates editable/focused composition attributes in
[GacUI/Source/Controls/TextEditorPackage/GuiDocumentCommonInterface.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/TextEditorPackage/GuiDocumentCommonInterface.cpp).

`SetPropertiesVisitor` passes resolved document colors directly to
`IGuiGraphicsParagraph::SetColor`, with a separate selection-color pass and no
enabled-state input, in
[GacUI/Source/GraphicsElement/GuiGraphicsDocumentRenderer_SetPropertiesVisitor.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/GraphicsElement/GuiGraphicsDocumentRenderer_SetPropertiesVisitor.cpp).
UIA also reads resolved document colors in
[GacUI/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationText.Windows.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/UIAutomation/WindowsUIAutomationText.Windows.cpp).
Thus the current skin retains black for default-colored disabled text rather
than the XP disabled foreground `#A1A192`; explicit author colors remain under
the document model's control.

Binding `BaselineDocument` to `VisuallyEnabled` alone cannot update the
installed control. Mutating the template's existing baseline also does not
update live document styles: `MergeBaselineStyle` copies values into new style
objects in
[GacUI/Source/Resources/GuiDocument.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Resources/GuiDocument.cpp).
Reinstalling templates or recoloring document runs is not a suitable paint
workaround. WinXPSkin keeps the existing document contract and records this
visual limitation; no application or upstream source change is applied.

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
