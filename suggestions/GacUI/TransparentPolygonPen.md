# A transparent polygon border paints black in GDI

## Repro

In the Win10Skin combo-box template, set the arrow polygon's border to `#00000000` and retain its state-dependent fill. Regenerate the skin and start FullControlTest with `/GDI /Hosted`. Select Win10Skin/Dark and open List → TextList. The narrow arrow paints black against the dark gray combo box. With `/D2D /Hosted` the same polygon shows its light fill.

## Workaround

Win10Skin and Win11Skin give fill-only glyphs a zero-alpha border with the same RGB channels as the current fill. This keeps the stroke invisible in Direct2D and gives GDI the correct foreground color in every state.

## Root Cause

The GDI polygon renderer selects both a pen and a brush whenever either color has nonzero alpha. The brush allocator supplies a hollow brush for zero alpha. The pen allocator always supplies a solid RGB pen, so a transparent black border draws an opaque black outline. [GacUI/Source/PlatformProviders/Windows/GDI/Renderers/GuiGraphicsWindowsGDI.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/GDI/Renderers/GuiGraphicsWindowsGDI.cpp) · [GacUI/Source/PlatformProviders/Windows/GDI/Renderers/GuiGraphicsRenderersWindowsGDI.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/GDI/Renderers/GuiGraphicsRenderersWindowsGDI.cpp)

## Proposal

Select a null pen for a polygon with zero border alpha. Verify a filled polygon with a transparent border and an outlined polygon with a transparent fill on both light and dark backgrounds.
