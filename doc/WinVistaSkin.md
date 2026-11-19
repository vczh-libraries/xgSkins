# Windows Vista Aero

Select `WinVistaSkin` under **Window Manager → Color Theme**. The template
draws a blue glass-style caption with a light reflection, white caption-button
glyphs and a red close button. Dialog controls use split gradients, blue hover
and focus feedback, white edit fields and continuous green progress. With a
system-managed frame, Windows draws the non-client area.

The frame represents glass using opaque color and translucent highlights.
The background behind the window does not participate in the rendering.
The control and title treatments follow the [Vista Aero control screenshot,
slide 25](https://archive.esug.org/ESUG2007/Thu/esug07-VAST75.pdf#page=25)
and Microsoft's [Vista Aero wizard illustrations](https://learn.microsoft.com/en-us/archive/msdn-magazine/2006/july/transactions-aero-wizards-and-task-dialogs-in-windows-vista).
The normal button gradient uses the four stops in Microsoft's
[WPF Aero theme dictionary](https://github.com/dotnet/wpf/blob/main/src/Microsoft.DotNet.Wpf/src/Themes/PresentationFramework.Aero/Themes/Aero.NormalColor.xaml).
The ribbon extends the desktop theme with Office 2007-style blue panels and
gold command feedback.

Compile `WinVistaSkinConfig.cpp` and the generated `WinVistaSkinPartialClasses.cpp`
and `WinVistaSkinResource.cpp` with GacUI. Enable `/bigobj` for the partial
classes on MSVC. Register the theme in `GuiMain` before creating controls.

```cpp
#include "Source/WinVistaSkin/WinVistaSkinConfig.h"

winvistaskin::SetColorPackage(winvistaskin::CreateDefaultColorPackage());
vl::presentation::theme::RegisterTheme(vl::Ptr(new winvistaskin::Theme));
```

To recolor existing controls, set the updated package and call
`vl::presentation::GetApplication()->RefreshThemes()`. See the
[color roles](../spec/WinVistaSkin/ColorPackage.md),
[animation behavior](../spec/WinVistaSkin/Animation.md) and
[control coverage](../spec/WinVistaSkin/TestGuidance.md).
