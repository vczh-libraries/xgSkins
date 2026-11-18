# Using and maintaining Win8Skin

Win8Skin implements the default light Windows 8 desktop appearance with current
GacUI control templates. Its XML resources are in
[Source/Win8Skin/UI](../Source/Win8Skin/UI/Resource.xml), generated C++ belongs in
`Source/Win8Skin/Source`, and its maintained C++ API is
[Win8SkinConfig.h](../Source/Win8Skin/Win8SkinConfig.h) and
[Win8SkinConfig.cpp](../Source/Win8Skin/Win8SkinConfig.cpp).

## C++ integration

Compile the generated skin sources and `Win8SkinConfig.cpp` alongside GacUI.
The generated resource source embeds the resources, so a separate resource
binary is not needed at runtime. Enable MSVC `/bigobj` for the generated
template bindings, following the test project. With this repository's root on
the include path, register the theme during `GuiMain`, before constructing
application controls:

```cpp
#include "Source/Win8Skin/Win8SkinConfig.h"

win8skin::SetColorPackage(win8skin::CreateDefaultColorPackage());
vl::presentation::theme::RegisterTheme(vl::Ptr(new win8skin::Theme));
```

`CreateDefaultColorPackage` returns the single default palette. `SetColorPackage`
forwards to `Theme::SetColorPackage` in
[Index.xml](../Source/Win8Skin/UI/Index.xml); it does not rebuild existing
templates. After changing the package or active registered theme, call
`vl::presentation::GetApplication()->RefreshThemes()`. Keep registration changes
outside template construction.

`FullControlTest` starts with DarkSkin. Select `Win8Skin` through
`Window Manager / Color Theme` to test it; no startup skin argument is required.
See [FullControlTest.md](FullControlTest.md) for the build and automation setup.
The showcase's custom dark navigation headers, swipe-list presentation, raw
drawings and explicit document colors retain their application-owned designs.

## Resource design

[Win8Skin.xml](../Source/Win8Skin/UI/Win8Skin.xml) contains `ColorPackage`, its
default factory, the `win8Colors` variable and the document baseline. All skin
types and helpers use the `win8skin` namespace. `ButtonColors` has five fields:
`Border`, `G1`, `G2`, `Text` and `Bullet`. `EditorColors` contains `Border` and
`Background`. Their declarations remain beside the corresponding button and
document templates. Shared bindings are in
[Style.xml](../Source/Win8Skin/UI/Style.xml), and `Index.xml` registers the theme
slots, including the ribbon.

This follows the XML/template organization of
[GacUI/Source/Skins/DarkSkin](https://github.com/vczh-libraries/GacUI/tree/master/Source/Skins/DarkSkin).
Edit the XML resources, then regenerate through `Source/GacUI.xml`. Preserve
container, focus, scrolling, menu-host and ribbon-layout contracts when changing
appearance. Every color, including transparent colors and helper artwork,
belongs in the color package. The
[color specification](../spec/Win8Skin/ColorPackage.md),
[animation specification](../spec/Win8Skin/Animation.md) and
[test-page mapping](../spec/Win8Skin/TestGuidance.md) describe the requirements.

Color animations use XML `Gradient` resources with linear 120 ms timing. The
imported finite-animation runtime omits its endpoint callback, so
`CompleteColorAnimation(animation, completed)` wraps each color animation.
Templates create the inner animation immediately to capture current colors and
the new target. The coroutine waits for completion and invokes a callback that
calls the builder's `Interpolate(1.0)`. Cancelling the wrapper also cancels its
inner animation and prevents an obsolete target transfer. A replacement begins
from the currently displayed colors. The shared upstream issue and local
workaround are explained in
[FiniteAnimationEndpoint.md](../suggestions/GacUI/FiniteAnimationEndpoint.md).

## Exact legacy data

Existing controls derive their colors and geometry from
[GacUI/Deprecated/Controls/Styles/Win8Styles](https://github.com/vczh-libraries/GacUI/tree/master/Deprecated/Controls/Styles/Win8Styles).
Those files supply data; the old style-controller interfaces are not compiled
into the new skin.

| Source | Details retained |
| --- | --- |
| [GacUI/Deprecated/Controls/Styles/Win8Styles/GuiWin8StylesCommon.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win8Styles/GuiWin8StylesCommon.cpp) | The 38 five-field button state packages, editor colors, text/selection colors, single button gradients, 13-pixel check/radio frames and solid radio mark. |
| [GacUI/Deprecated/Controls/Styles/Win8Styles/GuiWin8ScrollableStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win8Styles/GuiWin8ScrollableStyles.cpp) | Flat gray scrollbars, rectangular tracker channel, solid green progress, editor borders and gray general scroll-view surfaces. |
| [GacUI/Deprecated/Controls/Styles/Win8Styles/GuiWin8ScrollableStyles.h](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win8Styles/GuiWin8ScrollableStyles.h) | Scrollbar thickness 16; tracker channel thickness 4, padding 6 and grip dimensions 16 by 10. |
| [GacUI/Source/Controls/Styles/GuiCommonStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/04743022c4e7e3e441cb67ac9177891c8f7cdf9f/Source/Controls/Styles/GuiCommonStyles.cpp) at `04743022` | The old `BuildStyle` uses `defaultSize` for arrow-button length, minimum thumb and end insets. Its `arrowSize` argument is unused, so Win8 arrow buttons are nominally 16 pixels square despite the separate `ArrowSize = 8` declaration. |
| [GacUI/Deprecated/Controls/Styles/Win8Styles/GuiWin8ControlStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win8Styles/GuiWin8ControlStyles.cpp) | Single group-box border, pale-yellow tooltip/keytip surfaces, group-caption transitions and immediate calendar-date item states. |
| [GacUI/Deprecated/Controls/Styles/Win8Styles/GuiWin8MenuStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win8Styles/GuiWin8MenuStyles.cpp) and [GacUI/Deprecated/Controls/Styles/Win8Styles/GuiWin8ToolstripStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win8Styles/GuiWin8ToolstripStyles.cpp) | Flat menus, one-pixel gutter/toolbar separators, menu-bar edge colors, immediate menu states and animated toolbar faces. |
| [GacUI/Deprecated/Controls/Styles/Win8Styles/GuiWin8ListStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win8Styles/GuiWin8ListStyles.cpp) and [GacUI/Deprecated/Controls/Styles/Win8Styles/GuiWin8TabStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win8Styles/GuiWin8TabStyles.cpp) | Immediate list/tab feedback and the distinct tab-hover gradient, which differs slightly from pushbutton hover. |
| [GacUI/Source/Controls/Styles/GuiCommonStyles.h](https://github.com/vczh-libraries/GacUI/blob/04743022c4e7e3e441cb67ac9177891c8f7cdf9f/Source/Controls/Styles/GuiCommonStyles.h) at `04743022` | Shared linear color transfer, 120 ms duration and interruption from the displayed intermediate color. |

Two apparently older details are intentional. `Win8ListViewProvider` explicitly
constructs the Win7 column-header style, including its dropdown, and
[GacUI/Deprecated/Controls/Styles/GuiWin8Styles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/GuiWin8Styles.cpp)
uses the Win7 tree expander. Those measured header/tree colors and geometry are
preserved. The old Win8 tooltip remains pale yellow. Pushbuttons and tabs also
retain their measured subtle vertical gradients even though many other Win8
surfaces are flat.

## Ribbon and frame reconstruction

The old collection has no ribbon templates and delegates the nonclient window
frame to Windows. These areas use documented visual reconstructions:

- Microsoft's [Windows 8 brochure](https://download.microsoft.com/download/6/F/5/6F512314-780B-42D7-9D56-BA501352B78A/W8_brochure_download.pdf),
  PDF page 18, shows File Explorer's flat pale-gray ribbon, white tab row, fine
  separators and light-blue caption. In its 572 by 390 embedded screenshot,
  the caption at `(300, 15)` is `#B0CBE8`; ribbon samples at `(200, 65)` and
  `(200, 140)` are `#F5F6F8`, and the separator at `(213, 100)` is `#E2E3E5`.
  These are compressed screenshot samples, not published OS constants. The
  skin uses `#B0CBE8` for its default caption and the coherent legacy menu-bar
  color `#F5F6F7` for its flat ribbon.
- [Introducing Windows 8, Microsoft Press](https://download.microsoft.com/download/b/1/e/b1e7f4c9-304d-456c-bd96-a2287fa7871d/microsoft_press_ebook_introducing_windows_8_pdf.pdf),
  PDF page 39 / printed page 27, Figures 3-2 and 3-3, shows centered titles,
  square frames, simple minimize/maximize glyphs, a flat red close button and
  colored contextual tab bands. The skin's remaining active/inactive and
  hover/pressed frame colors are complementary approximations, including the
  red close-button states; they are not claimed as exact Microsoft constants.
- Microsoft's [Ribbon color documentation](https://learn.microsoft.com/en-us/windows/win32/windowsribbon/ribbon-color)
  explains that Windows 8 ties the highlight color to the background color.
  The reconstructed ribbon therefore uses the measured Win8 toolbar blue
  interaction palettes. Its normal/disabled faces preserve those RGB values
  with zero alpha over the ribbon surface. Ribbon-specific layouts, contextual
  tabs, split regions, gallery outlines and popup combinations follow current
  GacUI template contracts. Their appearance and 120 ms command transitions
  extend the legacy data rather than reproducing a missing old ribbon style.
- [DwmEnableBlurBehindWindow](https://learn.microsoft.com/en-us/windows/win32/api/dwmapi/nf-dwmapi-dwmenableblurbehindwindow)
  documents the removal of that blur effect beginning with Windows 8. The
  custom frame is opaque; it does not implement compositor glass or native
  window-decoration integration.

The [Application Menu documentation](https://learn.microsoft.com/en-us/windows/win32/windowsribbon/windowsribbon-controls-applicationmenu)
notes Windows 8's move to a File label, and Microsoft's
[File Explorer launch article](https://techcommunity.microsoft.com/blog/askperf/windows-8--windows-server-2012-file-explorer/375135)
describes contextual tabs, grouped commands, keytips and a collapsible ribbon.
These explain the visual references; application command names and behavior
remain the application's responsibility. Only one default color theme is
provided, without personalization, Classic or high-contrast variants.
