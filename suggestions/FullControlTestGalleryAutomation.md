# FullControlTest gallery activation through UI Automation

The Win7Skin gallery verification found that popup item backgrounds expose
unnamed UIA Toggle controls without an Invoke operation. UIA can locate the
nearby labels and scroll the gallery, but cannot activate these entries through
the command pattern used by the document-editor tests. The local test adapter
therefore uses automation IO to click the observed item bounds. This is recorded
as mixed UIA/service coverage, not a successful UIA Invoke check.

The showcase should expose each gallery item's visible caption as its accessible
name. The corresponding provider should expose a command operation that applies
the style even when that style is already selected; changing toggle or selection
state alone does not express reapplying a command. Verify this for inline, wide
popup and collapsed-group galleries.

Relevant upstream sources are
[GacUI/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
and
[Release/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/DocumentEditorRibbon.xml](https://github.com/vczh-libraries/Release/blob/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/DocumentEditorRibbon.xml).
No upstream provider or showcase source was modified for this workaround.
