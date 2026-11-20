# Switching skins after using a gallery tooltip can crash FullControlTest

## Repro

1. Start the Debug x64 `FullControlTest /D2D /Hosted` and resize the client to
   1400 × 900 before visiting **Control**. In **Window Manager**, select **Win11Skin**.
2. Open **Control / Document Editor (Ribbon) / Edit**. Expand the **Style**
   gallery, scroll down and click **Strong**. Hover over the inline **Strong**
   tile until its tooltip appears.
3. Type and select text in the editor, then apply **Header 1** from the inline gallery.
4. Switch to **Win11Skin/Dark**. Reopen the gallery, apply **Intense Emphasis**
   from the popup, then hover over its inline tile until the tooltip appears.
5. Return to **Window Manager** and select **Win11Skin**. The final switch
   raised an access violation in both the original and themed-label builds.

## Workaround

N/A

## Root Cause

The crash dump shows `GuiBindableRibbonGalleryList::MenuResetGroupTemplate`
destroying a gallery item during theme refresh. Its `GuiControl` destructor
calls `tooltipControl->GetRelatedControlHost()` through an invalid pointer.
One possible source of the stale pointer is `GuiApplication::ShowTooltip`,
which deletes the shared tooltip window when its owner window changes.
The tooltip window temporarily hosts content owned by the gallery item.
[Gallery template reset](https://github.com/vczh-libraries/GacUI/blob/2abe172bf/Source/Controls/ToolstripPackage/GuiRibbonGalleryList.cpp#L382) · [Control destruction](https://github.com/vczh-libraries/GacUI/blob/2abe172bf/Source/Application/Controls/GuiBasicControls.cpp#L517) · [Shared tooltip replacement](https://github.com/vczh-libraries/GacUI/blob/2abe172bf/Source/Application/Controls/GuiApplication.cpp#L307).

## Proposal

Trace when the shared tooltip window releases its temporary content as the pointer
moves between the gallery popup and the main window. Ensure the item retains
ownership until its own destruction. Add a regression that shows tooltips in both
windows and rebuilds the gallery through a skin change.
