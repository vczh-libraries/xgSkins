# GDI draws translucent tab hover fills as opaque

## Repro

Build the showcase at [revision f277fb5](https://github.com/vczh-libraries/xgSkins/tree/f277fb580a5941faf052382f76c1eb822b9e61b1). Run `FullControlTest /GDI /Hosted` and select `Win11Skin` in **Window Manager**.
On **Layout**, select **Responsive** and hover over **Easy Layout**. The hovered
header turns solid black. With `Win11Skin/Dark` it turns solid white. The same
colors appear on the horizontal **Complex Animation** header when **Gradient
Animation** is selected under **Misc / Animation**.

## Workaround

Win11Skin now uses opaque hover colors. On the ordinary tab strip the light and dark fills are `#E9E9E9` and `#2D2D2D`. Ribbon tabs use `#F5F5F5` and `#373737` over their different backing. At rest the header leaves its backing visible on both renderers.

## Root Cause

The original Windows 11 tab header used `#0000000A` in the light palette and `#FFFFFF0F`
in the dark palette. GDI's solid background renderer draws any color with a
nonzero alpha using a brush built from its RGB channels. Both tints therefore
cover the underlying surface completely.
[<GacUI-repo>/Source/PlatformProviders/Windows/GDI/Renderers/GuiGraphicsRenderersWindowsGDI.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/GDI/Renderers/GuiGraphicsRenderersWindowsGDI.cpp),
[<GacUI-repo>/Source/PlatformProviders/Windows/GDI/Renderers/GuiGraphicsWindowsGDI.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/PlatformProviders/Windows/GDI/Renderers/GuiGraphicsWindowsGDI.cpp).

## Proposal

Blend partially transparent solid backgrounds with the destination in the GDI
renderer. Verify rounded tab headers over both light and dark surfaces.
