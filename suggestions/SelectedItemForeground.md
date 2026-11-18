# Per-item selection foreground for graphical controls

WinXPSkin uses a pale blue selected-item fill with a blue border for built-in
list rows and calendar days. Native Windows XP's solid blue selection with
white text cannot be applied consistently through the current graphical
control-template contract. This is a documented palette approximation.
Menus and the combo box's own text label can use blue with white text because
their templates own those labels.

## Source findings

[GacUI/Source/Controls/Templates/GuiControlTemplates.h](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/Templates/GuiControlTemplates.h)
exposes a selectable background template for lists, one text color for text
lists and trees, and primary/secondary text colors for list views.
`GuiSelectableButtonTemplate` has `Selected` but no foreground-color contract
that graphical item renderers consume.

`OnStyleInstalled` in
[GacUI/Source/Controls/ListControlPackage/GuiTextListControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiTextListControls.cpp),
[GacUI/Source/Controls/ListControlPackage/GuiListViewControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiListViewControls.cpp),
and
[GacUI/Source/Controls/ListControlPackage/GuiTreeViewControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiTreeViewControls.cpp)
assigns colors from the parent control template. The six graphical list-view
renderers in
[GacUI/Source/Controls/ListControlPackage/ItemTemplate_IListViewItemView.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/ItemTemplate_IListViewItemView.cpp)
also use those shared colors. Replacing their item factories is not a transparent
skin fix: `GuiVirtualListView::OnItemTemplateChanged` changes `View` to
`Unknown`, and `SetView` installs each built-in factory and arranger again.

The existing `TuiListItemBackgroundTemplate` does expose selection colors.
However,
[GacUI/Source/Controls/ListControlPackage/GuiListControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiListControls.cpp)
initializes that connection only for a TUI application, and
[GacUI/Source/Controls/ListControlPackage/TuiItemTemplates.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/TuiItemTemplates.cpp)
makes `TuiGetItemBackground` return null in graphical applications. Merely
using that template in a graphical skin would not connect its colors to the
built-in item labels.

Calendar labels have a related gap.
`GuiCommonDatePickerLook` in
[GacUI/Source/Controls/Templates/GuiCommonTemplates.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/Templates/GuiCommonTemplates.cpp)
creates the day labels privately and `SetDay` assigns the current/adjacent-month
text color independently of the day button's selected state. A
`DateButtonTemplate` can paint its background and focus rectangle, but cannot
bind a selected foreground for the internally owned label.

## Workaround and proposed upstream change

Keep the existing built-in item factories, view modes, content colors, and
calendar behavior. Use the pale selection fill in WinXPSkin so framework-owned
labels remain readable. Do not traverse arbitrary item subtrees to recolor
labels: custom items and explicit application colors must retain ownership.

Add a renderer-independent per-item foreground contract consumed by built-in
text, checkbox, radio, tree, list-view, and grid renderers. It should receive
selection, enabled, and active-focus state, refresh after virtualization or
theme changes, and allow custom item templates to opt in without overriding
explicit label colors. Give the common date-picker look an equivalent
selected-day foreground input while retaining its primary/secondary month
colors.

Regression coverage should include all six list-view modes, checked/radio text
lists, trees, grids, calendar days in adjacent months, and custom colored item
content. Check selection changes, disabled state, focus transitions, scrolling,
item recycling, and skin refresh. Verify that using this contract does not
change `View`, the item provider, or the installed arranger.
