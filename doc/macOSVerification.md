# macOS FullControlTest verification

Verified on 2026-11-25 using macOS 26.5.2 (25F84), Apple Silicon and AppleClang 21.
The Cocoa snapshot was imported without edits from `iGac` commit `6322fa6`.
The shared libraries, showcase and skin resources came from this repository's
existing Windows-generated snapshots.

## Build and launch

The `import.sh`, `syncProj.sh`, `build.sh` sequence completed successfully.
The clean Debug build used C++20/Objective-C++20 and `VCZH_DEBUG_NO_REFLECTION`,
with no compiler warnings or errors. Repeating import and sync preserved the
snapshots, and the incremental build required no recompilation. The scripts
passed `bash -n`.

Both `test.sh --app:fct` (default hosted mode) and
`test.sh --app:fct --multiwindow` started `Complete Control Showcase` with a
working `/Automation/FullControlTest/Controls` and `/IO` service on port 8888.
Unknown arguments and conflicting window modes returned exit code 1 from both
the executable and the launcher. Windows renderer arguments are rejected on macOS.

## Runtime and rendering

Input was sent through the Cocoa application's automation service. Each state
change was checked against a fresh control tree, with window screenshots used
to inspect the actual CoreGraphics output.

| Check | Result |
| --- | --- |
| Initial page | Correct title, tabs and two empty lists; DarkSkin selected at startup. |
| Skin matrix | DarkSkin, Win7Skin, Win8Skin, WinXPSkin, WinVistaSkin, Win10Skin light/dark, Win11Skin light/dark and UbuntuSkin switched successfully in both modes: 20 combinations. |
| Lists in every combination | Add 10 items populated both lists with the same ten consecutive values; Clear removed all ten from both. The serial counter continues after Clear. |
| Visual inspection | Frames, tabs, group boxes, checkboxes, radio buttons, buttons and lists rendered with readable labels and the selected palette. |
| Editor input | Hosted Search accepted `macOS-Hosted Hello[Ab]{Cd}` exactly; the central editor accepted a separate marker. Both survived a List/Control round trip and switching to Win11Skin. Native Search input also survived tab changes. |
| Layout | Repeat, Responsive, Easy Layout and Easy Layout (Table) opened with their content. The vertical headers and the responsive-modal button rendered correctly. |
| Responsive modal | Hosted modal opened at 240 by 320 and closed with Cancel. Multi-window mode exposed a separate native window ID; input sent to that ID closed its modal and restored owner interaction. |
| Drawing | Elements rendered fills, borders, gradients and rounded shapes. Raw Clock showed its rim, marks and colored hands; screenshots confirmed advancing hands, correct redraw after leaving/returning, and continued rendering after a skin change. Touching showed the blue rectangle with its black border. |
| Native frame | Toggling Customized Frame off displayed the macOS traffic-light controls and title bar; toggling it back restored the skin frame. |
| Shutdown | The Exit tab's `self.Close() (InvokeInMainThread)` closed both sessions with exit code 0. Runtime logs contained no errors. |

Representative screenshots:

- [Hosted startup](../screenshots/macOS/hosted-initial.png)
- [XP lists](../screenshots/macOS/hosted-list-WinXPSkin.png)
- [Win11 dark controls](../screenshots/macOS/hosted-theme-Win11Skin-Dark.png)
- [Win11 editor and preserved text](../screenshots/macOS/hosted-editor-Win11Skin.png)
- [Hosted responsive modal](../screenshots/macOS/hosted-responsive-modal.png)
- [CoreGraphics raw clock](../screenshots/macOS/hosted-clock-Win11Skin.png)
- [Native macOS frame](../screenshots/macOS/multiwindow-native-frame.png)

This is platform build and representative UI coverage, not the complete upstream
document-editing, shortcut, resize and touch regression suite. Physical touch
acquisition is not provided by iGac. Existing showcase limitations, including
dark-background editor icon contrast, remain indexed in
[suggestions](../suggestions/README.md). No skin XML or generated C++ was changed.
