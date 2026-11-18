# Graphical list items have no selection-dependent text color

WinXPSkin cannot give a selected built-in row white text on a solid blue background
through the graphical item-background template.

## Repro

Select WinXPSkin in `FullControlTest /D2D /Hosted`. Select rows on
**List / TextList**, **List / TreeView** and **List / ListView**, and change the
ListView display mode. Compare selected and unselected labels. In the shipped skin the
selection fill is pale blue and the built-in labels keep their normal text color. A
solid-blue item background alone leaves those same labels in place.

## Workaround

WinXPSkin uses a pale blue selection fill with a blue border so the built-in labels
remain legible. It keeps the item providers, arrangers and view modes. Menus and the
combo box’s own label can use solid blue and white because their templates own the
text. [XP palette notes](../../doc/WinXPSkin.md).

## Root Cause

[<GacUI-repo>/Source/Controls/Templates/GuiControlTemplates.h](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/Templates/GuiControlTemplates.h)
exposes a selectable background template for lists, one text color for text
lists and trees, and primary/secondary text colors for list views.
`GuiSelectableButtonTemplate` has `Selected` but no foreground-color contract
that graphical item renderers consume.

`OnStyleInstalled` in
[<GacUI-repo>/Source/Controls/ListControlPackage/GuiTextListControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiTextListControls.cpp),
[<GacUI-repo>/Source/Controls/ListControlPackage/GuiListViewControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiListViewControls.cpp),
and
[<GacUI-repo>/Source/Controls/ListControlPackage/GuiTreeViewControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiTreeViewControls.cpp)
assigns colors from the parent control template. The six graphical list-view
renderers in
[<GacUI-repo>/Source/Controls/ListControlPackage/ItemTemplate_IListViewItemView.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/ItemTemplate_IListViewItemView.cpp)
also use those shared colors. Replacing their item factories is not a transparent
skin fix: `GuiVirtualListView::OnItemTemplateChanged` changes `View` to
`Unknown`, and `SetView` installs each built-in factory and arranger again.

The existing `TuiListItemBackgroundTemplate` does expose selection colors.
However,
[<GacUI-repo>/Source/Controls/ListControlPackage/GuiListControls.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/GuiListControls.cpp)
initializes that connection only for a TUI application, and
[<GacUI-repo>/Source/Controls/ListControlPackage/TuiItemTemplates.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/ListControlPackage/TuiItemTemplates.cpp)
makes `TuiGetItemBackground` return null in graphical applications. Merely
using that template in a graphical skin would not connect its colors to the
built-in item labels.

## Proposal

Expose a per-item foreground that built-in text, checkbox, radio, tree, list-view and
grid renderers can consume. Include selection, enabled and active-focus state. Let
custom templates opt in and preserve application-specified label colors. Verify all
six list-view modes, virtualization, focus, disabled items and skin refresh. Require
the original view, provider and arranger to survive.
[Related calendar issue](SelectedCalendarDayForeground.md).
