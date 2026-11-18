# Make a New Skin

All resource files should be put in `Source/<SKIN-NAME>/UI`.
All generated C++ files should be put in `Source/<SKIN-NAME>/Source`.
All manual maintained C++ files should be put in `Source/<SKIN-NAME>`.
The predefined `DarkSkin` is a good example to follow for creating a new skin, follow the pattern of `DarkSkin`, including file organization and naming conventions to complete the requirements below.
`DarkSkin` source files could be found at `<GacUI-repo>/Source/Skins/DarkSkin`.

## Resource Files

- All instances, types, functions and global variables should be under the "skin-name" namespace, which is the lower case version of `<SKIN-NAME>`.
- All colors are not allowed to hard code, a `ColorPackage` types should be created to store all color definitions.
- The static property `ColorPackage` should be added to the `Theme` class, for accessing a global color package variable.
- `<SKIN-NAME>.xml`:
  - Define the global color package variable, initialized with `CreateDefaultColorPackage`.
  - Define the `ColorPackage` struct.
  - Define the `CreateDefaultColorPackage` functions.
  - If multiple color themes are needed, a `CreateColorPackageInternal` could be created for `CreateDefaultColorPackage` and other color theme functions.
- `Index.xml`:
  - For the `Theme` class, which is an instance with a `<ThemeTemplates/>`.
- `Resource.xml`: the entry.

## C++ Files

All types, functions and global variables should be under the "skin-name" namespace, which is the lower case version of `<SKIN-NAME>`.
- `<SKIN-NAME>Config.(h|cpp)`:
  - Expose a `SetColorPackage` function to call `Theme::SetColorPackage`.
  - Expose a `CreateDefaultColorPackage` function to call the `CreateDefaultColorPackage` function defined in `<SKIN-NAME>.xml`.
  - Expose other color theme functions if required.

## Specification

`Spec/<SKIN-NAME>/TestGuidance.md` to maintain a bullet list, from any `<Instance/>` to affected test page in `FullControlTest`.
- Using this format: `- ClassName: TestPage1, TestPage2, ...`.
- This is for tracking a minimum set of test page affected when changing the skin.

`Spec/<SKIN-NAME>/ColorPackage.md` to maintain the usage of each `ColorPackage` item.

`Spec/<SKIN-NAME>/Animation.md` to explain how animation is used in each control or item template.
