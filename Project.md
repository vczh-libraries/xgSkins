# Project Organization

<!-- SECTION-START: FROZEN -->
<!-- Content in this section is now allowed to change unless explicit requested, unless you found any unreasonable design -->

You are strongly recommended to follow `<Release-repo>/.github/copilot-instructions.md` for:
- Coding convention.
- Building and debugging instructions.
- Document for upstream libraries.

When working on this repo:
- You are not allowed to change upstream repos.
- If upstream repos contain any bug prevent you from finishing the task:
  - If you find any useful workaround, you can use it, but you should list all workarounds, all upstream bugs and proposals to fix upstream repos in a suggestion file.
  - If you cannot find any useful workaround, you should list all upstream bugs and proposals to fix upstream repos in a suggestion file. In this case, you could ignore these bugs and continue to finish the other part.
  - The suggestion file should be put in the `suggestions` folder and commit.
    - Use `suggestions/<REPO-NAME>` for any issue in the library release from `vczh-libraries/<REPO-NAME>`.
    - Use `suggestions/FullControlTest` for any issue in the `FullControlTest` test app.
    - Use `suggestions` for any uncategorized issue, which I would expect to be rare.
    - The organization of a suggestion file should be:
      - `# Issue Name`: description of the issue.
      - `## Repro`: how to repro it using `FullControlTest`.
      - `## Workaround`: the workaround to fix the issue, if no workaround is available, write "N/A".
      - `## Root Cause`: the root cause of the upstream issue.
      - `## Proposal`: the proposal fix to upstream repos.
    - When it is more helpful you can add screenshots to a suggestion file, using the following naming convention: `<SUGGESTION-FILE>_<INDEX>.png`.

When you are explicitly asked to fix upstream repos, follow the instruction:
- Fix the repo and verify by running unit test.
- If the repo is not `GacUI`, release to `GacUI` and run unit test.
- Release the repo to `Release`.
- Follow `## Updating from Upstream Repos` to import the work to this repo.

When committing any files, you should put generated files in a separated commit, its title would be the origin commit title followed by `[generated]`.
- Changes caused by `import.ps1` should be committed with title `[import]`.
- Changes caused by `syncProj.ps1` should be committed with title `[syncProj]`.
- `syncProj.ps1` may update generated files, no need to make a separated `[syncProj] [generate]`.

## Dependencies

The follow dependencies are required in development activities, but they are not necessary just for building and running the project.

These repos under the same organization must be cloned as sibling folders:
- [Tools](https://github.com/vczh-libraries/Tools)
- [GacUI](https://github.com/vczh-libraries/GacUI)
- [Release](https://github.com/vczh-libraries/Release)

## Updating from Upstream Repos

Instruction here must be followed before doing any actual coding task.

Run `scripts/Windows/import.ps1`, which does:
- Update `Import` folder.

Run `scripts/Windows/syncProj.ps1`, which does:
- Copy specified files to `Test` folder.
  - Perform any necessary minimal fixing on copied files.
  - Limit these fixing on build breaks only, do not introduce feature changes or upgrades.
- Run `<Release-repo>/Tools/GacBuild.ps1` on `Test/GacUI.xml`.
  - If it reports missing any executable, build `<Release-repo>/Tools/Executables/Executables.sln` in `Release\x64` followed by running `<Release-repo>/Tools/CopyExecutables.ps1`.

Run `scripts/Windows/build.ps1`, which does:
- Build the following solution files, you could use `<Release-repo>/.github/Scripts/copilotBuild.ps1`:
  - `Test/TestApps.sln`

If any script fails, it could be possible that manual maintained source files need to update according to upstream changes. Fix those files and rerun the script.

## Project Structure

- `Source` folder
  - `GacUI.xml`
  - `<SKIN-NAME>` folder
    - `UI` folder: GacUI XML Resource files with assets.
      - `Resource.xml`: The entry.
    - `Source` folder: generated files from `UI/Resource.xml`.
- `Test` folder
  - `FullControlTest` folder
    - Copied files from `<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin`:
      - `UI/FullControlTest` folder.
      - `FullControlTestRaw*.(h|cpp)`
      - `SharedDocumentEditor.(h|cpp)`
    - Generated files:
      - `UI/Source` folder: generated files from `UI/FullControlTest/Resource.xml`. The generated `FullControlTestResource.cpp` will be used to avoid the need of loading a binary resource file in runtime.
    - Manual maintained files:
      - `FullControlTest.vcxproj(.filters)`
      - `FullControlTestEventHandlers.(h|cpp)`:
        - Serve a similar purpose as `<Release-repo>/Tutorial/GacUI_ControlTemplate/BlackSkin/FullControlTestEventHandlers.(h|cpp)`, but it should instead list:
          - `DarkSkin`: the predefined dark skin with default color theme.
          - `<SKIN-NAME>`: the skin from `Source/<SKIN-NAME>`.
          - `<SKIN-NAME>/THEME`: the skin from `Source/<SKIN-NAME>`, only when such skin has multiple color themes.
      - `Main.cpp`: start the test app for demoing skins.
  - `TestApps.sln`
  - `GacUI.xml`
- `Spec` folder
  - `<SKIN-NAME>` folder
    - `Animation.md`: Explaining animations for a skin.
    - `ColorPackage.md`: Explaining colors for a skin.
    - `TestGuidance.md`: Test guidance when changing a skin.

The initial content of `GacUI.xml` is just one line `<GacUI/>`, other contents are added only when necessary.
Only run `GacBuild.ps1` on `Source/GacUI.xml` when any files in `Source/<SKIN-NAME>/UI` is changed.

## Test Apps for Verification

Unless explicitly requested, `VCZH_DEBUG_NO_REFLECTION` should be specified for all test projects.
Automation service is always required to start for all GacUI GUI applications.

Project and compile options could copy from sln or vcxproj files in the `Release` repo, including:
- `Windows SDK Version`: `Windows 10.0 SDK (latest)`
- `Platform Toolset`: `v145 for Microsoft C++ Build Tools`
- `C++ Language Standard`: `ISO C++ 20 Standard`
- `Include Directories`: add the `REPO-ROOT/Import` folder
- `Use Library Dependency Inputs`: `Yes`
- `Preprocessor`:
  - `VCZH_DEBUG_NO_REFLECTION`: all reflection code will be eliminated during compiling
  - debug profile
    - `VCZH_CHECK_MEMORY_LEAKS`
    - memory leaks checking should only be applied on debug profile with `_CrtDumpMemoryLeaks` in `WinMain`.

## Verification

Unless explicitly requested, follow the instruction to verify when a skin is changed:
- When creating a skin, run the full test, otherwise collect affected test pages from `Spec/<SKIN-NAME>/TestGuidance.md`, and only verify against these test pages.
- Follow `<GacUI-repo>/.github/Jobs/DebugRemoteProtocolSop.md` to verify `FullControlTest /D2D /Hosted`.

<!-- SECTION-END: FROZEN -->

### FullControlTest

It should support the following arguments:
- General:
  - `/Hosted`: The default option when not specified, uses the hosted mode.
  - `/MultiWindow`: Exclusive with `/Hosted`, does not use the hosted mode.
- Windows:
  - `/D2D`: The default option when not specified, uses the Direct2D renderer.
  - `/GDI`: Exclusive with `/D2D`, uses the GDI renderer.
