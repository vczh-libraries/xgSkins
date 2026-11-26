# Ubuntu FullControlTest verification

Verified on Ubuntu 26.04.1 LTS in a Wayland session on 2026-11-25, using
Clang 21.1.8, CMake 4.2.3 and the system Cairo/Pango libraries. The build uses
C++20 and `VCZH_DEBUG_NO_REFLECTION`.

The 65 files in `Import/WGac` and `Import/WGacShared` match
[wGac commit 1fe82b3](https://github.com/vczh-libraries/wGac/commit/1fe82b3a8f7f4065e05db690d0592e0c786cbb02)
byte for byte. Framework sources and generated skin/showcase resources come
from this repository's existing snapshot. No sibling repository was changed.

## Build and launch

The Linux import, synchronization and build scripts completed successfully.
All dependencies were already installed, so the prerequisite installer was not
run. Shell syntax checks and rejection of invalid arguments passed. The
executable rejects unknown switches, Windows renderer switches, and simultaneous
`/Hosted` and `/MultiWindow`.

## Application checks

The native automation service was used to drive the actual Wayland application.
The checks follow the applicable operations in
`<GacUI-repo>/.github/Jobs/DebugRemoteProtocolSop.md`.

| Check | Result |
| --- | --- |
| Hosted and native multi-window startup | Correct title, initial DarkSkin and usable tabs; automation responds in both modes. |
| TextList | Add produces two complete ten-item sequences; Clear removes both sequences. |
| Search and rich editor | Independent exact text survives page changes. |
| Local input | Ctrl+Q and Ctrl+Alt+Super+Q show their expected dialogs. All five mouse buttons report down/up and Alt/Super combinations correctly. |
| Skin switching | All ten entries work in both modes: DarkSkin, Win7Skin, Win8Skin, WinXPSkin, WinVistaSkin, Win10Skin light/dark, Win11Skin light/dark and UbuntuSkin. |
| Hosted ribbon editor | Context-menu selection, clipboard operations, undo/redo, font/color dialogs, text effects, paragraph alignment, hyperlinks and read-only modes passed. |
| Hosted document persistence | Image insertion/undo/redo, private save/reload with embedded images, RTF/HTML exports and file-dialog cancellation passed. |
| Hosted style gallery | All eight styles apply and reapply while preserving the selected range. |
| Hosted layout | Vertical pages and editor state survive theme changes. The responsive modal opens at 240×320, resizes, presents its account menu, and closes repeatedly through OK/Cancel. Owner input resumes. |
| Default arguments | Launching the executable without arguments selects hosted mode. |
| Raw painters | In both modes and all ten themes, clock data advances and the corresponding clock-region pixels change. White rim and cyan/green/yellow hands remain visible. Touching paints 15,484 SkyBlue pixels and 1,040 black border pixels in both modes. |
| Shutdown | Closing through Exit / `self.Close() (InvokeInMainThread)` terminates both modes with exit code 0. |

## Rendering evidence

Window Manager, TextList, the ribbon editor, Easy Layout and Raw Clock were
captured for every theme in both modes. The captures come from the application's
Wayland shared-memory drawing buffers, selecting the last buffer committed to
the surface using the Wayland protocol trace; they are not desktop screenshots.

The [screenshot index](../screenshots/README.md) contains retained examples and
theme overviews. Frames, labels, selected radio buttons, checkboxes, lists,
vertical tabs and light/dark backgrounds were inspected visually.

Detailed local automation trees, logs, exported documents and captures are in
the ignored `scripts/Linux/.build/verification` directory. A clean rebuild
removes this directory.

## Limits

- The GlobalShortcuts portal rejected registration because the terminal-launched
  process has no installed desktop identity. Window Manager correctly reports
  `Global shortcut unavailable`. Installing a desktop entry outside this repo
  was outside the requested scope; global activation is not verified.
- Input checks used the application's automation service. Physical keyboard,
  mouse, touch and AT-SPI coverage are not claimed. wGac does not acquire native
  touch, so the SOP's Toolstrip point-input scenario does not apply.
- Synthetic Escape did not dismiss a nonactivating context menu in the hosted
  editor check. Clicking outside dismissed it and preserved the selection, as
  allowed by the SOP.
- The existing showcase's dark-background icon contrast limitation remains
  documented in [EditorAndGridContrast](../suggestions/FullControlTest/EditorAndGridContrast.md).
