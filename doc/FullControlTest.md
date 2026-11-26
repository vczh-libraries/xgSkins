# Building and running FullControlTest

## macOS

Install the Xcode Command Line Tools (`xcode-select --install`) and CMake
(`brew install cmake`). From the repository root, build and run with:

```bash
scripts/macOS/build.sh
scripts/macOS/test.sh --app:fct
```

The checked-in imports and generated resources are sufficient for this build.
To refresh the Cocoa backend, clone the
[iGac repository](https://github.com/vczh-libraries/iGac) beside this repository,
then run the development sequence:

```bash
scripts/macOS/import.sh
scripts/macOS/syncProj.sh
scripts/macOS/build.sh
scripts/macOS/test.sh --app:fct --hosted
```

`import.sh` mirrors `iGac/Mac` and `iGac/MacShared` into `Import`. `syncProj.sh`
checks that the imported helpers and checked-in shared sources are present;
the current snapshots need no source patches. Synchronizing `Release` and the
showcase XML, or regenerating skins, still requires the Windows workflow below.
The document editor uses the existing `Test/FullControlTest/SharedDocumentEditor.cpp`
because the current `iGac/MacShared` snapshot does not contain that helper.

`build.sh` configures a C++20/Objective-C++20 Debug build with reflection disabled
and builds all test apps. Pass CMake options such as `-DCMAKE_BUILD_TYPE=Release`
to change the configuration; set `CMAKE_BUILD_PARALLEL_LEVEL` to change the
default four build jobs. All output goes into the ignored `scripts/macOS/.build`
directory. The app bundle is `scripts/macOS/.build/bin/FullControlTest.app`.
No sibling repository or downloaded resource is required to run it.

CoreGraphics renders both window modes. Hosted mode is the default;
`scripts/macOS/test.sh --app:fct --multiwindow` uses separate native windows.
The executable also accepts `/Hosted` and `/MultiWindow` directly, with
`--hosted` and `--multiwindow` aliases. Conflicting modes and unknown arguments
are rejected. The automation endpoint below is available in both modes.

## Windows

Development on Windows requires Visual Studio C++ Build Tools with the `v145`
toolset, the latest Windows 10 SDK, and the sibling
[Release repository](https://github.com/vczh-libraries/Release). Configure
`VLPP_VSDEVCMD_PATH` as described in `<Release-repo>/.github/Guidelines/Building.md`.

Run these commands in PowerShell from the repository root:

```powershell
$repoRoot = (Get-Location).Path
& "$repoRoot/scripts/Windows/import.ps1"
& "$repoRoot/scripts/Windows/syncProj.ps1"
& "$repoRoot/scripts/Windows/build.ps1"
```

`import.ps1` copies the upstream libraries into `Import/Release` and
`Import/Release-Test`. `syncProj.ps1` copies the showcase resources, raw drawing
code and document editor from
[Release/Tutorial/GacUI_ControlTemplate/BlackSkin](https://github.com/vczh-libraries/Release/tree/master/Tutorial/GacUI_ControlTemplate/BlackSkin),
then runs GacBuild on `Test/GacUI.xml`. It adjusts the resource configuration to
generate code into `Test/FullControlTest/UI/Source` and embed the resources in
`FullControlTestResource.cpp`. No external resource binary is required at runtime.

If the resource tools are missing, build
[Release/Tools/Executables/Executables.sln](https://github.com/vczh-libraries/Release/blob/master/Tools/Executables/Executables.sln)
in `Release|x64` using the upstream build wrapper, then run
[Release/Tools/CopyExecutables.ps1](https://github.com/vczh-libraries/Release/blob/master/Tools/CopyExecutables.ps1).

When a skin resource changes, regenerate its sources before building:

```powershell
& "C:/Code/VczhLibraries/Release/Tools/GacBuild.ps1" -FileName "$repoRoot/Source/GacUI.xml"
```

Use the absolute path to your sibling Release checkout when it differs.

`build.ps1` builds `Test/TestApps.sln` using the upstream build wrapper. It defaults
to `Debug|x64`; use `-Configuration Release` and/or `-Platform Win32` for the other
configurations. The project compiles without reflection. Debug builds enable CRT
memory leak checking.

## Ubuntu

For development, place the [wGac repository](https://github.com/vczh-libraries/wGac)
beside this checkout, then run from this repository:

```bash
./scripts/Linux/import.sh
./scripts/Linux/syncProj.sh
./scripts/Linux/build.sh
```

`import.sh` mirrors `wGac/WGac` and `wGac/WGacShared` into `Import`. It does not
run upstream scripts or change sibling checkouts. `syncProj.sh` checks the shared
generated showcase and Wayland drawing sources; no compatibility rewrites are
currently necessary. The existing `Import/Release` snapshot supplies GacUI. A
fresh checkout already contains all imported/generated sources and can run
`build.sh` directly without sibling repositories.

The build uses CMake, C++20 and Clang by default, with reflection disabled.
Override `CC` and `CXX` on the first build to select another compiler.
Build products live in the ignored `scripts/Linux/.build` directory.
Use `build.sh --rebuild` for a clean build. Builds are serial by default because
the amalgamated framework sources consume substantial memory; set
`CMAKE_BUILD_PARALLEL_LEVEL` if more build workers fit in memory.

If the build fails because a system dependency is missing, run:

```bash
sudo ./scripts/Linux/build-prerequisites-ubuntu.sh
./scripts/Linux/build.sh
```

The prerequisite script installs packages through Ubuntu's package manager:
the compiler/build tools, Wayland, XKBCommon, Cairo/Pango, Fontconfig, GIO,
liburing and libdecor (including its GTK decoration plugin). The build itself
does not download or install dependencies.

Run from a Wayland desktop session with `WAYLAND_DISPLAY` and `XDG_RUNTIME_DIR`
available:

```bash
./scripts/Linux/test.sh --app:fct --hosted
./scripts/Linux/test.sh --app:fct
```

The launcher selects hosted mode with `--hosted` and native multi-window mode
without it. The executable `scripts/Linux/.build/bin/FullControlTest` accepts
`/Hosted` (its default) or `/MultiWindow`, exclusively. Rendering uses
Wayland/Cairo/Pango, including the Raw Clock and Touching painters. Native
Wayland touch acquisition is not supported by wGac.

Local shortcuts work through the application. The GlobalShortcuts portal also
requires an installed desktop identity for a terminal-launched application,
with its matching `WGAC_APPLICATION_ID`; otherwise Window Manager reports
`Global shortcut unavailable`. This launcher does not install files in the
user's desktop application directory. See
[wGac's shortcut setup](https://github.com/vczh-libraries/wGac#readme).

## Running on Windows

On Windows, launch `Test/<Platform>/<Configuration>/FullControlTest.exe`, for example
`Test/x64/Debug/FullControlTest.exe`. `/Hosted` and `/D2D` are the defaults.
Use `/MultiWindow` for native windows or `/GDI` for the GDI renderer.
`/Hosted` and `/MultiWindow` are mutually
exclusive, as are `/D2D` and `/GDI`.

## Selecting a skin

The skin list contains `DarkSkin`, `Win7Skin`, `Win8Skin`, `WinXPSkin`, `WinVistaSkin`, `Win10Skin`, `Win10Skin/Dark`, `Win11Skin`, `Win11Skin/Dark`, `UbuntuSkin`.
Startup always selects `DarkSkin`; choose a skin in `Window Manager`. The manually maintained
`Test/FullControlTest/FullControlTestEventHandlers.cpp` owns this list. Skins
belong in `Source/<SKIN-NAME>` following [Project.md](../Project.md).

The bare `Win10Skin` entry uses the light palette. Choose `Win10Skin/Dark` for dark mode. In C++, use `CreateDefaultColorPackage()` or `CreateDarkColorPackage()` from the `win10skin` namespace.

The bare `Win11Skin` entry uses the light palette. Choose `Win11Skin/Dark` for dark mode. In C++, use `CreateDefaultColorPackage()` or `CreateDarkColorPackage()` from the `win11skin` namespace.

## Automation

The application starts its automation service in every configuration:

- `GET http://localhost:8888/Automation/FullControlTest/Controls` inspects the UI.
- `POST http://localhost:8888/Automation/FullControlTest/IO` sends input commands.

For example, in PowerShell 7:

```powershell
$automationUrl = 'http://localhost:8888/Automation/FullControlTest'
Invoke-RestMethod "$automationUrl/Controls"
Invoke-RestMethod "$automationUrl/IO" -Method Post `
    -ContentType 'application/json; charset=utf8' -SkipHeaderValidation -Body '!Exit'
```

On macOS:

```bash
curl --fail http://localhost:8888/Automation/FullControlTest/Controls
curl --fail -H 'Content-Type: application/json; charset=utf8' \
  --data-binary '!Exit' http://localhost:8888/Automation/FullControlTest/IO
```

The IO body is a command string, and the content type must match the example.
`-SkipHeaderValidation` preserves the endpoint's required `utf8` spelling.
`Queued` means the input was accepted; inspect `Controls` afterward to verify its
effect. Hosted mode uses `/IO` without a window ID. Multi-window mode also accepts
`/IO/<windowId>` using IDs from `Controls`.

Ubuntu exposes the same endpoints through MiniHTTP. For example:

```bash
curl --fail http://localhost:8888/Automation/FullControlTest/Controls
curl --fail -H 'Content-Type: application/json; charset=utf8' \
    --data-binary '!Exit' http://localhost:8888/Automation/FullControlTest/IO
```

Run one showcase process at a time because both modes use port 8888.

For a startup smoke check, inspect the initial `List` / `TextList` page, click
`Add 10 items`, and verify that both lists contain ten items. `Clear` should empty
both lists. On `Window Manager`, the `Color Theme` group should contain exactly
one selected option, `DarkSkin`, when first opened. Return to `List` to leave the initial page open.

To check control sizes, open `Window Manager` with all theme choices visible and run
[`scripts/Windows/verifyControlSizes.ps1`](../scripts/Windows/verifyControlSizes.ps1).
It compares the control and label bounds of the seven checkboxes, the button below
them, and the theme choices with `DarkSkin` after each switch. It measures from
the main tab so each skin can keep its window frame.
