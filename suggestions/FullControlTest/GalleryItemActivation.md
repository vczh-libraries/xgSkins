# Gallery popup entries expose Toggle without an apply command

UI Automation can locate and scroll style-gallery entries. The popup entries lack a
named command for applying a style again.

## Repro

Open **Control / Document Editor (Ribbon)** in `FullControlTest /D2D /Hosted` with
Win7Skin. Open the **Style** gallery dropdown and inspect a style’s caption and its
selectable background with UIA. The adjacent caption is readable, but the background
is an unnamed Toggle control without Invoke. Compare the inline, wide-popup and
collapsed-group presentations.

## Workaround

The verification adapter locates and scrolls to the item with UIA, then uses
automation-service pointer input at the observed bounds to apply it. This provides
mixed UIA/service coverage.

## Root Cause

The sample separates the caption from the selectable background. The observed
accessible patterns express selection or toggling. Applying an already selected style
also requires a command.
[<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/DocumentEditorRibbon.xml](https://github.com/vczh-libraries/Release/blob/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/DocumentEditorRibbon.xml)
·
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).

## Proposal

The showcase should expose each gallery item's visible caption as its accessible
name. The corresponding provider should expose a command operation that applies
the style even when that style is already selected. Changing toggle or selection
state alone does not express reapplying a command. Verify this for inline, wide
popup and collapsed-group galleries.
