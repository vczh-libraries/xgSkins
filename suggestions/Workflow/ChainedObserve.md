# Chaining two explicit observations can stop skin generation

GacGen terminates while compiling a text field that observes changes of host and then observes activation on that host.

## Repro

In UbuntuSkin's `EditorBorderTemplate`, replace the `renderTargetChanged` handler and `Backdrop` binding with the following binding. Regenerate the skin for FullControlTest with GacBuild on `Source/GacUI.xml`. The x32 pass stops during validation of the instance constructor. A single control template with just the `Entry` and `Backdrop` Boolean properties reproduces the same failure.

```xml
<att.Backdrop-bind><![CDATA[
  self.observe as frame(frame.Entry ? frame.RelatedControlHost : null on frame.renderTargetChanged, frame.EntryChanged)
      .observe as host(host is not null and not host.RenderingAsActivated on host.WindowActivated, host.WindowDeactivated)
]]></att.Backdrop-bind>
```

## Workaround

UbuntuSkin records the enclosing window template in `EntryWindow` when the composition's render target changes. The backdrop binding reads the template's observable activation and enablement properties with a fallback for detached fields. [Editor template](../../Source/UbuntuSkin/UI/Template_Document.xml).

## Root Cause

CDB stopped on a duplicate dictionary key in `CreateBindContextVisitor::Visit(WfReferenceExpression*)`. When resolving an observation's alias, the visitor records the alias reference in `context.renames` and visits the observation's parent to collect its dependencies. In the chain above it revisits the inner observation and tries to register the same syntax node twice. [Workflow binding analysis](https://github.com/vczh-libraries/Workflow/blob/a6b66eb05/Source/Analyzer/WfAnalyzer_ExpandBindExpression.cpp).

## Proposal

Reuse the existing alias mapping when a dependency traversal revisits a reference. Test a two-stage observation with a nullable intermediate host. Verify that changing the host detaches the previous activation handlers and delivers updates from the new host exactly once.
