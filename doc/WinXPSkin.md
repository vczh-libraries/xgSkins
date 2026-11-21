# Using and maintaining WinXPSkin

WinXPSkin reconstructs Windows XP's default blue Luna appearance with current
GacUI control templates. It provides one palette. The separate Windows Classic
appearance, Silver/Olive variants, Royale, Zune and desktop personalization are
outside its scope.

The XML resources are in
[Source/WinXPSkin/UI](../Source/WinXPSkin/UI/Resource.xml), generated C++ belongs
in `Source/WinXPSkin/Source`, and the maintained C++ API is
[WinXPSkinConfig.h](../Source/WinXPSkin/WinXPSkinConfig.h) and
[WinXPSkinConfig.cpp](../Source/WinXPSkin/WinXPSkinConfig.cpp).

## C++ integration

Compile the generated skin sources and `WinXPSkinConfig.cpp` alongside GacUI.
The generated resource source embeds the resources; no separate resource
binary is needed at runtime. Enable MSVC `/bigobj` for the generated template
bindings, following the test project. With this repository's root on the
include path, register the theme during `GuiMain`, before constructing controls:

```cpp
#include "Source/WinXPSkin/WinXPSkinConfig.h"

winxpskin::SetColorPackage(winxpskin::CreateDefaultColorPackage());
vl::presentation::theme::RegisterTheme(vl::Ptr(new winxpskin::Theme));
```

`CreateDefaultColorPackage` returns the single default palette.
`SetColorPackage` forwards to `Theme::SetColorPackage` in
[Index.xml](../Source/WinXPSkin/UI/Index.xml); it does not rebuild existing
templates. After changing the package or active registered theme, call
`vl::presentation::GetApplication()->RefreshThemes()`. Keep registration changes
outside template construction.

FullControlTest starts with DarkSkin. Select WinXPSkin through
`Window Manager / Color Theme`; no startup skin argument is required. See
[FullControlTest.md](FullControlTest.md) for building and automation. Application
content, custom showcase drawings and explicit document formatting retain their
own designs.

## Resource design

[WinXPSkin.xml](../Source/WinXPSkin/UI/WinXPSkin.xml) declares `ColorPackage`,
its default factory, the `winxpColors` global and the document baseline. Skin
types and helpers use the `winxpskin` namespace. `ButtonColors` contains
`Border`, `Inner`, `G1`, `G2`, `Text` and `Bullet`; `EditorColors` contains
`Border` and `Background`. Shared XML bindings live in
[Style.xml](../Source/WinXPSkin/UI/Style.xml).

The organization follows
[GacUI/Source/Skins/DarkSkin](https://github.com/vczh-libraries/GacUI/tree/master/Source/Skins/DarkSkin).
Edit the XML and regenerate through `Source/GacUI.xml`. All paint colors,
including transparency and decorative glyphs, belong in the color package.
Preserve container, focus, scroll, menu-host and responsive ribbon contracts.
The [color specification](../spec/WinXPSkin/ColorPackage.md),
[animation specification](../spec/WinXPSkin/Animation.md) and
[test-page mapping](../spec/WinXPSkin/TestGuidance.md) define the requirements.

State colors change immediately. The skin does not inherit the Win7/Win8
120-millisecond color-animation helpers. This is an explicit reconstruction
policy, not a claim that Windows XP had no animations: control behavior,
caret timing, tooltips and application animations remain owned by GacUI and
the application.

## Research and reconstruction

- Microsoft's 25 October 2001 article,
  [Using Windows XP Visual Styles and PrintWindow in Windows Applications](https://learn.microsoft.com/en-us/previous-versions/ms997649(v=msdn.10)),
  Figure 1, shows Calculator and Display Properties with the default blue
  appearance. It supplies a primary visual reference for the blue caption,
  red close button, beige surfaces and rounded upper corners. Its GIF is
  color-reduced, so its pixels are not treated as published OS constants.
- The preserved Microsoft copyright-2001
  [Windows XP Visual Guidelines: Controls](https://www.retrospace.net/download/WebApplications/WindowsXPDesignGuidelines/controls.htm)
  provides state illustrations and selected explicit colors. Its editor border
  is `#7F9DB9`, disabled editor fill `#EBEBE4`, disabled control text `#A1A192`,
  group caption `#0046D5`, and menu highlight `#316AC5` with white text. This is
  Microsoft-authored material hosted by an archive, not a current Microsoft
  support page. The corresponding
  [Colors](https://www.retrospace.net/download/WebApplications/WindowsXPDesignGuidelines/colors.htm)
  page provides representative palette values rather than a complete skin.
- The guide's
  [Fonts](https://www.retrospace.net/download/WebApplications/WindowsXPDesignGuidelines/fonts.htm)
  page identifies Trebuchet MS Bold 10-point window captions and Tahoma body
  text. The custom caption uses Trebuchet MS Bold with a minimum size of 13
  logical pixels, an approximation of 10 points at 96 DPI, and honors a larger
  supplied font size. Ordinary controls retain their application-provided
  `DisplayFont`.
- Microsoft's MIT-licensed
  [dotnet/wpf/src/Microsoft.DotNet.Wpf/src/Themes/PresentationFramework.Luna/Themes/Luna.NormalColor.xaml](https://github.com/dotnet/wpf/blob/main/src/Microsoft.DotNet.Wpf/src/Themes/PresentationFramework.Luna/Themes/Luna.NormalColor.xaml),
  [dotnet/wpf/src/Microsoft.DotNet.Wpf/src/Themes/PresentationFramework.Luna/Microsoft/Windows/Themes/ButtonChrome.cs](https://github.com/dotnet/wpf/blob/main/src/Microsoft.DotNet.Wpf/src/Themes/PresentationFramework.Luna/Microsoft/Windows/Themes/ButtonChrome.cs)
  and
  [dotnet/wpf/src/Microsoft.DotNet.Wpf/src/Themes/PresentationFramework.Luna/Microsoft/Windows/Themes/ScrollChrome.cs](https://github.com/dotnet/wpf/blob/main/src/Microsoft.DotNet.Wpf/src/Themes/PresentationFramework.Luna/Microsoft/Windows/Themes/ScrollChrome.cs)
  provide another primary reference for Luna paint data. These WPF brushes are
  identified as WPF references, not proof of every native XP bitmap texel or
  metric. The GacUI XML compositions are independently constructed; no Windows
  theme bitmap or WPF template is shipped with this skin.

Luna chrome is reconstructed with borders, gradients and small vector glyphs.
Some richer native/WPF edge shading is reduced to a two-color face and inner
rim. Caption colors include visual approximations from the archived state
images. The custom frame has a blue gradient, rounded upper corners, square
lower corners, left-aligned white caption text with a one-pixel blue shadow,
and blue/red caption faces with a 21-pixel minimum size. Their row may grow to
accommodate the caption font. It does not implement native nonclient
painting or a Windows theme service. The inactive close button keeps a muted
red face; its two gradient samples come from the archived caption state sheet,
where disabled caption controls instead have a muted blue face.

The ribbon, its contextual tabs, group launchers and galleries are new designs.
The ribbon pairs Luna’s beige panels, tab shapes and blue captions with the
toolstrip’s command highlights. The default palette uses the same five button
states for ribbon and toolstrip commands. Applications can customize their
colors independently.

Built-in list/tree/grid item foregrounds are not selected-state template
properties, and calendar labels are separately owned by the date-picker look.
Those item faces therefore use a pale blue fill with the characteristic blue
outline to keep their inherited dark text legible. Menus and document
selection, whose foregrounds are available to the skin, use the blue/white
pair. Read-only editor mode is likewise not exposed as a distinct editor-border
template state; the documented disabled fill does not imply a separate
read-only rendering path. The upstream contracts, safe palette workaround and
proposed foreground API are documented in
[selected list-item text](../suggestions/GacUI/SelectedItemForeground.md) and
[selected calendar-day text](../suggestions/GacUI/SelectedCalendarDayForeground.md).

Disabled document-based text boxes change their fill to `#EBEBE4`, but plain
text retains the black document baseline instead of XP's gray disabled text.
The template API has no disabled foreground paint property, and its baseline
is consumed when the template is installed. Recoloring document runs or
reinstalling templates on each enabled-state change would disturb application
formatting and document state. WinXPSkin preserves those contracts and records
this fidelity limitation; explicit document colors remain intact. The source
findings and proposed transient renderer property are in
[DisabledDocumentForeground.md](../suggestions/GacUI/DisabledDocumentForeground.md).

Pushbuttons fit their text or embedded content with four logical pixels of
padding on each side and two above and below. A blue inner rim and dotted
rectangle indicate keyboard focus, and hover uses the orange rim. Checkbox
and radio artwork is 13 pixels inside a 17-pixel cell.
Scrollbars use 20-pixel arrow buttons and blue thumb faces with light/shadow
grip stripes. Determinate progress has six-pixel green chunks separated by
two-pixel gaps, following the block metrics in WPF's shared
[dotnet/wpf/src/Microsoft.DotNet.Wpf/src/Themes/Shared/Microsoft/Windows/Themes/ProgressBarBrushConverter.cs](https://github.com/dotnet/wpf/blob/main/src/Microsoft.DotNet.Wpf/src/Themes/Shared/Microsoft/Windows/Themes/ProgressBarBrushConverter.cs),
used by its Luna theme. Intermediate values show complete chunks; at full
coverage a partial final chunk may be clipped to the track.
These are logical-pixel reconstruction metrics, not a claim that every native
XP DPI asset used the same dimensions.

The progress repeater uses `range[0, self.ChunkCount)` to create one identical
chunk per item. Its Workflow factory ignores the ordinal and constructs a
parameterless chunk template. Geometry, colors and layout are defined in XML.
An earlier variant tried to declare the boxed ordinal as a
[constructor parameter](../suggestions/GacUI/BoxedItemTemplateParameter.md).

The requested chunk count is also calculated by an XML binding. A small
`QueueChunkCount` helper coalesces requests and publishes the latest count
through `GuiApplication::InvokeInMainThread`; only that published count rebuilds
the repeat stack. This keeps child creation outside the current layout
traversal. An independently captured shared state is marked inactive by the
template destructor, and the callback checks it before accessing the template.
This deferred structural update adds no decorative animation or timer. The
observed layout failure and scheduling/lifetime contract are documented in
[ProgressChunkLayoutMutation.md](../suggestions/GacUI/ProgressChunkLayoutMutation.md).

Generation, build and runtime evidence is tracked separately in
[WinXPSkinVerification.md](WinXPSkinVerification.md).
