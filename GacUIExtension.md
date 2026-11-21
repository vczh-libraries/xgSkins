# GacUI Extension Convention

<!-- SECTION-START: FROZEN -->
<!-- Content in this section is now allowed to change unless explicit requested -->

This document defines project and file organization rules.
Rules in `General Rules` must be followed.
Rules in `XXX Specific` is only effective when the platform is listed in "Supported platform for development activities", which means rules for non listed platforms should be ignored.
Listed folders and files are not forced to exist, they should be created only when needed.

## General Rules

Project structure:
- `Import` folder: It only contains files copied from upstream repos. Files in this folder is not allowed manual update.
- `Source` folder: Source files for release.
- `Test` folder: Project files for verification, including source files only for test purpose.
- `Product` folder: Project files for release. When the extension not only release source files, but also release applications, these applications are put in here.
- `spec` folder: Specification of the extension. `spec/README.md` should index all document files in this folder.
- `doc` folder: Documentation of the extension. `doc/README.md` should index all document files in this folder.

### Maintaining Documents

- DO NOT mix up specification and documentation.
- Specification describes:
  - What purpose does the extension service.
  - How should the extension look like.
  - It should focus on requirements, such as scope, non scope, what user would expect to see.
- Documentation describes:
  - API usage.
  - Background inside design.
  - It should focus on technical details.
- Use a hyperlink `[<XXX-repo>/path/to/file](github-url)` to reference files that is not in this repo.
  - If the target file is a document, you could skip the url path while quoting the path in a pair of (`).
- `GacUIExtension.md` is not allowed to change.

### Maintaining .gitignore

You are only allowed to update the `# Repo-specific` section:
- Files could be updated after running `GacBuild.ps1` or `GacGen.ps1`, log folders should be ignored, specify each log folder.
- Files from building should not be committed, the `.gitignore` files already ignored common MSBuild generated files.

### Policy for Development Activities

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
- If any request happened to resolve or invalid suggestion files, even when it is not explicitly pointed out, you still need to remove or update affected suggestion files, to keep them fresh.
- Maintain a `suggestions/README.md` to index all suggestion files, with a simple symptom description for each.
- To identify the root cause, debugger is ready for you when needed, check out `<Release-repo>/.github/Guidelines/Debugging.md`.

When you are explicitly asked to fix upstream repos, follow the instruction:
- Fix the repo and verify by running unit test.
- If the repo is not `GacUI`, release to `GacUI` and run unit test.
- Release the repo to `Release`.
- Follow `Project.md` to import the work to this repo.

## Platform Specific Rules

### Window Specific

Project structure:
- `Import/Release` folder: a copy of `<Release-repo>/Import`.
- `Import/Release-Test` folder: a copy of `<Release-repo>/Import-Test`.
- `Test` folder:
  - `TestApps.sln`: Solution file.
  - `<PROJECT-NAME>/<PROJECt-NAME>.(vcxproj|vcxproj.filters|vcxitems|)`: Project files referenced by the solution file.
- `Product` folder:
  - `Products.sln`: Solution file.
  - `<PROJECT-NAME>/<PROJECt-NAME>.(vcxproj|vcxproj.filters|vcxitems|)`: Project files referenced by the solution file.

These folders should be added to C++ include list:
- `Import/Release`
- `Import/Release-Test`

### Linux Specific

<!-- to be edited -->

### macOS Specific

<!-- to be edited -->

### GacJS Specific

<!-- to be edited -->

<!-- SECTION-END: FROZEN -->
