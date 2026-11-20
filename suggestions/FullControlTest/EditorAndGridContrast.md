# Fixed-color command icons and website links lose contrast on dark skins

## Repro

Start `FullControlTest /D2D /Hosted` with DarkSkin. Open **Control / Document Editor (Ribbon)**, select some text and inspect the alignment and text formatting commands. The same artwork appears in the toolstrip editor. On a dark surface, the black strokes are difficult to distinguish even when the commands are enabled. Open **List / BindableDataGrid** and inspect the Website column. The link remains pure blue when the cell background is dark.

## Workaround

N/A

## Root Cause

The showcase assigns foreground-colored PNGs to commands and ribbon icon labels. The image frame draws the supplied pixels and exposes no tint property. The built-in graphical hyperlink visualizer explicitly sets its label to RGB (0, 0, 255) independently of the grid's colors. [Showcase toolbar resources](https://github.com/vczh-libraries/Release/tree/master/Tutorial/GacUI_ControlTemplate/BlackSkin/UI/FullControlTest/ToolbarImages) · [GacUI image frame](https://github.com/vczh-libraries/GacUI/blob/master/Source/GraphicsElement/GuiGraphicsElement.h) · [GacUI grid visualizers](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiDataGridExtensions.cpp)

## Proposal

Allow graphical hyperlink visualizers to obtain a link foreground from the active list or document palette. Preserve the Website column's hand cursor, hover underline and cell editor. Give the showcase monochrome commands access to light and dark artwork or tintable image masks. Verify palette switches while a document editor and a populated grid are open.
