# Using and maintaining Win7Skin

Win7Skin is a control-template implementation of the default Windows 7 desktop
appearance. Its source resources are in
[Source/Win7Skin/UI](../Source/Win7Skin/UI/Resource.xml). Generated C++ is in
`Source/Win7Skin/Source`; the hand-maintained C++ API is
[Win7SkinConfig.h](../Source/Win7Skin/Win7SkinConfig.h) and
[Win7SkinConfig.cpp](../Source/Win7Skin/Win7SkinConfig.cpp).

## C++ integration

Compile the generated skin sources and `Win7SkinConfig.cpp` into the application
alongside GacUI. The generated resource source embeds the skin resources,
so this configuration does not need a separate resource binary at runtime.
With MSVC, compile `Win7SkinPartialClasses.cpp` with `/bigobj`; its generated
template bindings exceed the default object-section limit.
With this repository's root on the include path, select the package and register
the theme during `GuiMain`, before creating application controls:

```cpp
#include "Source/Win7Skin/Win7SkinConfig.h"

win7skin::SetColorPackage(win7skin::CreateDefaultColorPackage());
vl::presentation::theme::RegisterTheme(vl::Ptr(new win7skin::Theme));
```

`win7skin::CreateDefaultColorPackage` returns the complete default palette.
`win7skin::SetColorPackage` forwards to the generated
`win7skin::Theme::SetColorPackage` accessor defined in
[Index.xml](../Source/Win7Skin/UI/Index.xml). It does not refresh already-created
templates by itself. After changing a package or the registered active theme,
call `vl::presentation::GetApplication()->RefreshThemes()` to rebuild existing
control templates. Keep registration changes outside the lifetime of a template
construction operation. Only the default named color theme is provided.

The test application's skin selector performs registration and refresh for the
user. Start `FullControlTest` normally, then select `Win7Skin` in
`Window Manager / Color Theme`. Startup remains DarkSkin. See
[FullControlTest.md](FullControlTest.md) for building, launch modes and automation.

Use `<VTab/>` for a vertical tab control. The showcase's Layout page uses
`<RibbonTab ControlThemeName="VTab">` so it can place a button below the headers.
The showcase supplies its own swipe-to-delete rows and date readouts. Their
fixed colors can be hard to read under Win7Skin. [Showcase text colors](../suggestions/FullControlTest/ShowcaseSkinColors.md).

## Resource organization

[Win7Skin.xml](../Source/Win7Skin/UI/Win7Skin.xml) declares `ColorPackage`, its
default factory, global package and document baseline. The nested `ButtonColors`
and `EditorColors` structures live with their button and document resources.
All skin declarations
use the `win7skin` namespace. [Index.xml](../Source/Win7Skin/UI/Index.xml)
registers every current theme slot, including ribbon controls. Shared bindings
live in [Style.xml](../Source/Win7Skin/UI/Style.xml), and each
`Template_*.xml` describes composition, elements and control-template bindings.
This follows the organization of
[GacUI/Source/Skins/DarkSkin](https://github.com/vczh-libraries/GacUI/tree/master/Source/Skins/DarkSkin).

Change the XML resources and regenerate with the `Source/GacUI.xml` build entry;
do not edit generated C++. Preserve the supplied layout and command contracts
when changing appearance: container compositions, focusable compositions,
scroll commands, submenu hosts and ribbon group/gallery hosts are part of the
control-template interface. Colors belong in the package, including transparent
colors, text, glyphs, gradients and newly researched artwork.

Color transitions remain XML `Gradient` animations with linear 120 ms timing.
The imported finite-animation runtime omits its final callback, so the Workflow
helper `CompleteColorAnimation(animation, completed)` in `Template_Button.xml`
completes the exact target color. Templates create the inner animation
immediately, capturing its starting colors and target, then retain the helper's
coroutine wrapper. The wrapper waits for the inner animation and invokes the
supplied callback, which calls its builder's `Interpolate(1.0)`.
Killing the wrapper interrupts both animations;
the cancelled coroutine does not transfer its old target, and the next
transition continues from the displayed colors. See
[FiniteAnimationEndpoint.md](../suggestions/GacUI/FiniteAnimationEndpoint.md) for the
upstream cause and removal condition for this local workaround.

The [color specification](../spec/Win7Skin/ColorPackage.md),
[animation specification](../spec/Win7Skin/Animation.md) and
[test-page mapping](../spec/Win7Skin/TestGuidance.md) describe the expected
appearance and verification scope.

## Sources and fidelity

The primary reference for existing controls is
[GacUI/Deprecated/Controls/Styles/Win7Styles](https://github.com/vczh-libraries/GacUI/tree/master/Deprecated/Controls/Styles/Win7Styles).
Those sources supply the colors and artwork. Control bounds, text padding and
scroll-view gutters follow DarkSkin so that applications can switch themes
without moving controls within the window client area.

| Reference | Information carried into the templates |
| --- | --- |
| [GacUI/Deprecated/Controls/Styles/Win7Styles/GuiWin7StylesCommon.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win7Styles/GuiWin7StylesCommon.cpp) | Button/check/radio/list/tab state colors, two-half button gradients, diagonal check/radio gradients, text colors and selection colors. |
| [GacUI/Deprecated/Controls/Styles/Win7Styles/GuiWin7ScrollableStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win7Styles/GuiWin7ScrollableStyles.cpp) | Scroll and tracker construction, green progress gradients and editor focus colors. |
| [GacUI/Deprecated/Controls/Styles/Win7Styles/GuiWin7ListStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win7Styles/GuiWin7ListStyles.cpp) | Immediate list/header/expander feedback, header gradients and hollow/filled tree arrows. |
| [GacUI/Deprecated/Controls/Styles/Win7Styles/GuiWin7MenuStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win7Styles/GuiWin7MenuStyles.cpp) | Menu popup border/inset, menu-bar gradients and menu geometry. |
| [GacUI/Deprecated/Controls/Styles/Win7Styles/GuiWin7ToolstripStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win7Styles/GuiWin7ToolstripStyles.cpp) | Toolbar buttons, split regions and separators. |
| [GacUI/Deprecated/Controls/Styles/Win7Styles/GuiWin7ControlStyles.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Deprecated/Controls/Styles/Win7Styles/GuiWin7ControlStyles.cpp) | Window client background, pale-yellow tooltips, group boxes and calendar colors. |
| [GacUI/Source/Controls/Styles/GuiCommonStyles.h](https://github.com/vczh-libraries/GacUI/blob/04743022c4e7e3e441cb67ac9177891c8f7cdf9f/Source/Controls/Styles/GuiCommonStyles.h) at commit `04743022` | The original transfer macro restarts at 120 milliseconds and continues from the current color when interrupted. |

The historical style interfaces predate ribbon templates and custom-frame
windows. These areas require interpretation rather than direct translation:

- **Ribbon:** Microsoft's [Windows Ribbon introduction](https://learn.microsoft.com/en-us/windows/win32/windowsribbon/windowsribbon-introduction)
  includes a [Windows 7 Paint screenshot](https://learn.microsoft.com/en-us/windows/win32/windowsribbon/images/overviews/screenshot-paint-win7transparency-mirror.png).
  It supplies the visual reference for pale-blue surfaces, fine group separators,
  captions and gold interaction colors. For example, `#DCE7F5` was sampled near
  the panel bottom and `#FCC45B` from the highlighted button edge. Remaining
  ribbon gradient/state values are complementary approximations chosen for this
  implementation; Microsoft does not document them as exact constants.
- **Ribbon layout and galleries:** the [Windows 7 ribbon guide](https://learn.microsoft.com/en-us/windows/win32/uxguide/cmd-ribbons)
  describes labeled command groups, small/large commands and galleries.
  Microsoft's [color-picker examples](https://learn.microsoft.com/en-us/windows/win32/windowsribbon/windowsribbon-controls-dropdowncolorpicker)
  provide additional popup and grouped-gallery references. GacUI's existing
  ribbon layout and commands remain responsible for sizing and interaction.
- **Custom frame:** the original `Win7WindowStyle` delegates nonclient rendering
  to Windows. The new hosted frame uses an opaque blue gradient and red close
  button based on the same Windows 7 screenshots. It approximates the visible
  color treatment and does not implement Desktop Window Manager glass, blur,
  desktop reflections or an OS-native Aero frame.
- **Modern combinations:** toolbar-in-menu containers, contextual ribbon tabs
  and other combinations with no legacy style counterpart use the related
  menu, ribbon or tab colors and current GacUI template contracts.

The [Ribbon color documentation](https://learn.microsoft.com/en-us/windows/win32/windowsribbon/ribbon-color)
distinguishes Windows 7's independent highlight color from the Windows 8
behavior. This is why Win7Skin has its own ribbon palette instead of treating
the ribbon as an ordinary gray toolbar.

Microsoft's [Windows 7 animation guidance](https://learn.microsoft.com/en-us/windows/win32/uxguide/vis-animations)
supports short, interruptible feedback. The 120-millisecond value comes from
the legacy source above. Its [font guidance](https://learn.microsoft.com/en-us/windows/win32/uxguide/vis-fonts)
identifies Segoe UI at 9 points as the Windows UI default; the templates continue
to accept the application/system font through normal GacUI bindings.
