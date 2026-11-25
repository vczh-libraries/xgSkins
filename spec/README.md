# Specification

This extension provides additional template-based skins for GacUI applications.
Each skin supplies a default color theme. FullControlTest starts with DarkSkin;
use Window Manager to select another skin.

The custom skins use a four-pixel visible frame along the sides and bottom of a
resizable window. The close button ends at the inside edge of this frame. Beside
and below the client, five more pixels of client background also accept resizing.

Group boxes show their parent surface through the body and the gap in the
outline around the caption. The empty space after the last tab button on each
header row also shows the parent surface. Each tab page supplies its own background.

`VTab` places the headers in a column to the left of the page. Captions stay
horizontal and share a right edge. Borders, highlights and selection marks
along the top and bottom of a Tab header run along the left and right of a
VTab header. Unused space below the headers shows the parent surface.

- Win7Skin: [colors](Win7Skin/ColorPackage.md), [animation](Win7Skin/Animation.md),
  [test guidance](Win7Skin/TestGuidance.md).
- Win8Skin: [colors](Win8Skin/ColorPackage.md), [animation](Win8Skin/Animation.md),
  [test guidance](Win8Skin/TestGuidance.md).
- WinXPSkin: [colors](WinXPSkin/ColorPackage.md), [animation](WinXPSkin/Animation.md),
  [test guidance](WinXPSkin/TestGuidance.md).
- WinVistaSkin: [colors](WinVistaSkin/ColorPackage.md), [animation](WinVistaSkin/Animation.md),
  [test guidance](WinVistaSkin/TestGuidance.md).
- Win10Skin (light and dark): [colors](Win10Skin/ColorPackage.md), [animation](Win10Skin/Animation.md),
  [test guidance](Win10Skin/TestGuidance.md).
- Win11Skin (light and dark): [colors](Win11Skin/ColorPackage.md), [animation](Win11Skin/Animation.md),
  [test guidance](Win11Skin/TestGuidance.md).
- UbuntuSkin: [colors](UbuntuSkin/ColorPackage.md), [animation](UbuntuSkin/Animation.md),
  [test guidance](UbuntuSkin/TestGuidance.md).
