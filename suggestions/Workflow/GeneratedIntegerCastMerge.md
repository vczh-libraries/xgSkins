# The C++ merger rejects a fixed-width cast emitted on only one architecture

Generating the XP progress template can succeed on x86 and x64 independently and then
fail when Workflow merges the two C++ outputs.

## Repro

Use FullControlTest’s WinXPSkin progress fixture with explicit `Int32` casts around
the native-integer endpoints of the chunk range. From the xgSkins root run
`..\Release\Tools\GacBuild.ps1 -FileName .\Source\GacUI.xml`. Both Workflow
compilations succeeded. The merger reported the first mismatch in the generated
progress subscription at row 21846, columns 171 (x86) and 201 (x64), before the
showcase could run. The recorded log is `%TEMP%/xgskins-winxp-gacbuild.log`.
[XP build record](../../doc/WinXPSkinVerification.md#baseline-and-generation).

## Workaround

Use the native-integer range `range[0, self.ChunkCount)` for the repeated progress
chunks. The current showcase displays the result on **Layout / Repeat**.
[XP progress template](../../Source/WinXPSkin/UI/Template_Scroll.xml).

## Root Cause

The `Int32` conversion is redundant for a native integer on x86, so its C++ expression
omits the cast. The x64 output retains it. The merger recognizes integer-type and
literal-suffix substitutions. An extra cast changes the structure of the expression.
[<Workflow-repo>/Source/Cpp/WfMergeCpp.cpp](https://github.com/vczh-libraries/Workflow/blob/master/Source/Cpp/WfMergeCpp.cpp).

## Proposal

Emit the redundant cast consistently on both architectures, or normalize equivalent
expressions before merging. Generate and merge the same progress subscription for x86
and x64, covering empty, partial and complete ranges.
