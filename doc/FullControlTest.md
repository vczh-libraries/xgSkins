# Building and running FullControlTest

Development requires Windows, Visual Studio C++ Build Tools with the `v145`
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

## Running

Launch `Test/<Platform>/<Configuration>/FullControlTest.exe`, for example
`Test/x64/Debug/FullControlTest.exe`. `/Hosted` and `/D2D` are the defaults.
Use `/MultiWindow` for native windows or `/GDI` for the GDI renderer.
`/Hosted` and `/MultiWindow` are mutually
exclusive, as are `/D2D` and `/GDI`.

The skin list contains `DarkSkin` and `Win7Skin`, each with its default color theme.
Startup always selects `DarkSkin`; choose a skin in `Window Manager`. The manually maintained
`Test/FullControlTest/FullControlTestEventHandlers.cpp` owns this list. Skins
belong in `Source/<SKIN-NAME>` following [Project.md](../Project.md).

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

The IO body is a command string, and the content type must match the example.
`-SkipHeaderValidation` preserves the endpoint's required `utf8` spelling.
`Queued` means the input was accepted; inspect `Controls` afterward to verify its
effect. Hosted mode uses `/IO` without a window ID. Multi-window mode also accepts
`/IO/<windowId>` using IDs from `Controls`.

For a startup smoke check, inspect the initial `List` / `TextList` page, click
`Add 10 items`, and verify that both lists contain ten items. `Clear` should empty
both lists. On `Window Manager`, the `Color Theme` group should contain exactly
one selected option, `DarkSkin`, and an unselected `Win7Skin` option. Return to `List` to leave the initial page open.
