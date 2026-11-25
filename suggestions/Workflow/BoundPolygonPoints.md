# Binding a polygon's point list can stop GacGen

## Repro

In a FullControlTest skin, use the following binding on the polygon in `RibbonGroupExpandButtonTemplate`. Rebuild `Source/GacUI.xml`. GacGen stops with access violation `0xC0000005` while validating the template constructor. The same binding reproduces the failure in a resource containing only this button.

```xml
<ButtonTemplate ref.Name="self">
  <Polygon Size="x:7 y:7">
    <att.Points-bind><![CDATA[
      let top = {x:6; y:0;} of Point, corner = {x:6; y:6;} of Point,
          left = {x:0; y:6;} of Point in (
        self.State == ButtonState::Active ? {top corner left} : {top corner left top left corner}
      )
    ]]></att.Points-bind>
  </Polygon>
</ButtonTemplate>
```

## Workaround

Give each polygon a fixed `att.Points` list and bind its parent composition's visibility to the button state. The skin uses one path for the outline and one for the filled triangle.

## Root Cause

The debugger stops in `CreateBindContextVisitor::Visit(WfConstructorExpression*)`. For a positional list item the parser stores the expression in `key` and leaves `value` empty. The visitor calls `DirectDepend` on both and dereferences the empty expression when collecting binding dependencies. [Workflow binding expansion](https://github.com/vczh-libraries/Workflow/blob/master/Source/Analyzer/WfAnalyzer_ExpandBindExpression.cpp)

## Proposal

Visit the expressions present in each constructor argument. Add a compiler test that updates a bound list of points when the controlling property changes.
