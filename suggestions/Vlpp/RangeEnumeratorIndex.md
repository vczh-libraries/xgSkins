# A fixed-width integer range fails to compile on x64

The FullControlTest XP progress example exposed an incompatible return type when it
enumerated fixed-width integers on x64.

## Repro

Use the XP progress template variant whose chunk range has `Int32` endpoints converted
through `double`. Run `..\Release\Tools\GacBuild.ps1 -FileName .\Source\GacUI.xml` in
xgSkins and then `.\scripts\Windows\build.ps1 -Configuration Debug -Platform x64`.
Generation and merging succeeded. Building FullControlTest reported MSVC C2555 for
`RangeEnumerator<vint32_t>::Index()`. See
`%TEMP%/xgskins-winxp-range-build-failure.log`.
[XP build record](../../doc/WinXPSkinVerification.md#baseline-and-generation).

## Workaround

Use a range of native integers for the ordinal source of the XP progress chunks. This
preserves their six-pixel width and two-pixel spacing on **Layout / Repeat**.
[XP progress template](../../Source/WinXPSkin/UI/Template_Scroll.xml).

## Root Cause

`RangeEnumerator<T>::Index()` returns `T`. Its base interface, `IEnumerator<T>`,
declares `Index()` with native return type `vint`. The two types differ when `T` is
`vint32_t` on x64.
[<Vlpp-repo>/Source/Collections/OperationEnumerable.h](https://github.com/vczh-libraries/Vlpp/blob/master/Source/Collections/OperationEnumerable.h).

## Proposal

Return `vint` from the override. Instantiate and enumerate fixed-width and
native-width ranges on both x86 and x64, and verify the reported indices.
