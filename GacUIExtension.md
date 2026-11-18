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
