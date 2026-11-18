# The item-template parameter shorthand treats a boxed value as a class pointer

Declaring the generic item value through XML shorthand prevents the XP progress chunk template from compiling.

## Repro

In the FullControlTest XP progress fixture, declare the repeated chunk’s item
constructor parameter with `<ref.Parameter Name="value" Class="system::Object"/>` and
use the chunk as the item template. Run
`..\Release\Tools\GacBuild.ps1 -FileName .\Source\GacUI.xml` in xgSkins. Workflow
semantic validation rejects the generated `system::Object^` parameter before the
showcase starts.

## Workaround

The XP progress repeater supplies an `ItemTemplate-eval` factory that accepts
`value : object`, ignores the ordinal and constructs a parameterless
`ProgressChunkTemplate`. The repeat count, six-pixel width, two-pixel spacing,
gradients and layout stay in XML.
[XP progress template](../../Source/WinXPSkin/UI/Template_Scroll.xml).

## Root Cause

`Workflow_GetSuggestedParameterType` generates a shared-pointer type for this
shorthand. The boxed object is a value type and cannot be used as the target of that
pointer.
[<GacUI-repo>/Source/Compiler/WorkflowCodegen/GuiInstanceLoader_WorkflowCollectReferences.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Compiler/WorkflowCodegen/GuiInstanceLoader_WorkflowCollectReferences.cpp).

## Proposal

Handle the boxed object explicitly when generating the constructor parameter type.
Compile an XML item template with a generic boxed parameter and check that it
constructs the correct number of chunks for empty, partial and full progress.
