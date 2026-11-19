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
