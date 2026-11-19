# Windows 11 showcase verification

Run the full showcase in Direct2D hosted mode for both `Win11Skin` and `Win11Skin/Dark`. The entries use the same templates. The second entry changes the color package. Follow the application test procedure in [Project.md](../../Project.md).

## Instance-to-page mapping

- win11skin::Theme: Window Manager, List / TextList, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Repeat, Misc / DatePicker.
- win11skin::CustomControlTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Responsive, Misc / TouchingList.
- win11skin::TooltipTemplate: Control / Document Editor (Ribbon).
- win11skin::SystemFrameWindowTemplate: Window Manager, Misc / Dialogs.
- win11skin::CustomFrameWindowTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- win11skin::CaptionButtonTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- win11skin::CaptionCloseButtonTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- win11skin::GroupBoxTemplate: List / TextList, Control / TextBox, Window Manager.
- win11skin::LabelTemplate: List / TextList, Layout / Easy Layout, Window Manager, Misc / Localization.
- win11skin::ShortcutKeyTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Window Manager.
- win11skin::DateButtonTemplate: Misc / DatePicker, List / BindableDataGrid.
- win11skin::DatePickerTemplate: Misc / DatePicker, List / BindableDataGrid.
- win11skin::ButtonTemplate: List / TextList, Layout / Easy Layout, Control / TextBox, Misc / Dialogs.
- win11skin::CheckBoxTemplate: List / TextList, Layout / Easy Layout, Control / TextBox, Misc / TouchingList.
- win11skin::RadioButtonTemplate: List / TextList, Window Manager.
- win11skin::DocumentLabelTemplate: Control / TextBox / Document, Control / Embedded Controls.
- win11skin::DocumentTextBoxTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Layout / Easy Layout.
- win11skin::DocumentViewerTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Control / Embedded Controls.
- win11skin::EditorBorderTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Easy Layout, List / TextList, List / ListView, List / TreeView.
- win11skin::TabHeaderButtonTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- win11skin::TabHeaderTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- win11skin::TabTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- win11skin::RibbonTabTemplate: Control / Document Editor (Ribbon).
- win11skin::ItemBackgroundTemplate: List / TextList, List / ListView, List / TreeView, List / BindableDataGrid, Control / Document Editor (Ribbon).
- win11skin::TextListTemplate: List / TextList, Refresh List / TextList, Refresh List / BindableTextList, Layout / Easy Layout.
- win11skin::ComboBoxTemplate: List / ListView, List / BindableDataGrid, Layout / Easy Layout, Misc / DatePicker, Misc / Localization.
- win11skin::ListViewColumnHeaderTemplate: List / ListView, List / BindableDataGrid, Refresh List / ListView, Refresh List / BindableDataGrid.
- win11skin::ListViewColumnDropDownTemplate: List / BindableDataGrid, Refresh List / BindableDataGrid.
- win11skin::ListViewTemplate: List / ListView, List / BindableDataGrid, Refresh List / ListView, Refresh List / BindableListView, Refresh List / BindableDataGrid.
- win11skin::ExpandingDecoratorTemplate: List / TreeView, Refresh List / TreeView, Refresh List / BindableTreeView, List / BindableDataGrid.
- win11skin::TreeViewTemplate: List / TreeView, Refresh List / TreeView, Refresh List / BindableTreeView, List / BindableDataGrid.
- win11skin::LeftScrollButtonTemplate: Layout / Repeat, List / ListView.
- win11skin::RightScrollButtonTemplate: Layout / Repeat, List / ListView.
- win11skin::TopScrollButtonTemplate: Layout / Repeat, List / TextList.
- win11skin::BottomScrollButtonTemplate: Layout / Repeat, List / TextList.
- win11skin::HScrollHandleTemplate: Layout / Repeat, List / ListView.
- win11skin::VScrollHandleTemplate: Layout / Repeat, List / TextList.
- win11skin::HTrackerHandleTemplate: Layout / Repeat.
- win11skin::VTrackerHandleTemplate: Layout / Repeat.
- win11skin::HScrollTemplate: Layout / Repeat, List / ListView, Control / TextBox.
- win11skin::VScrollTemplate: Layout / Repeat, List / TextList, Control / TextBox, Control / Document Editor (Ribbon).
- win11skin::HTrackerTemplate: Layout / Repeat.
- win11skin::VTrackerTemplate: Layout / Repeat.
- win11skin::ProgressBarTemplate: Layout / Repeat.
- win11skin::ScrollViewTemplate: Layout / Repeat, Layout / Responsive, Control / Embedded Controls, Misc / TouchingList.
- win11skin::ToolstripTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- win11skin::MenuBarTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- win11skin::ToolstripInMenuTemplate: Control / Document Editor (Ribbon).
- win11skin::ToolstripMenuTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), List / BindableDataGrid.
- win11skin::ToolstripSplitterTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win11skin::ToolstripSplitterInMenuTemplate: Control / Document Editor (Ribbon).
- win11skin::MenuSplitterTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip).
- win11skin::ToolstripButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win11skin::ToolstripDropdownButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win11skin::ToolstripSplitArrowTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win11skin::ToolstripSplitButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win11skin::MenuBarButtonTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- win11skin::MenuItemButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon), List / BindableDataGrid.
- win11skin::RibbonSmallButtonTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonSmallDropdownButtonTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonSmallSplitButtonTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonSmallSplitArrowTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonLargeButtonTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonLargeDropdownButtonTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonSplitArrowTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonLargeSplitButtonTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonSmallIconLabelTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonIconLabelTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonSplitterTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonGroupTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonGroupExpandButtonTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonGroupMenuTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonButtonsTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonToolstripsTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonToolstripHeaderTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonGalleryTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonGalleryItemListTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonToolstripMenuTemplate: Control / Document Editor (Ribbon).
- win11skin::RibbonGalleryDropdownButtonTemplate: Control / Document Editor (Ribbon).

## Desktop control measurements

At 96 DPI with the default font, inspect commands and options on List / TextList and Window Manager. Command buttons, single-line editors and closed combos have 23-pixel minimum heights. Checkboxes and radios use 13-pixel artwork in a 17-pixel minimum row. Tabs use three pixels of vertical text padding. Increase the application font and confirm text can expand each control. The 16-pixel toolbar icons and larger ribbon commands retain their separate sizes. [Win32 control sizing](https://learn.microsoft.com/en-us/windows/win32/uxguide/vis-layout#recommended-sizing-and-spacing).

## Observations in both modes

- In Window Manager, switch from an existing skin to light, to dark, then back to light. Check inactive and active captions, the close button, hover states, glyphs and popup borders. Change an editable value and a selection before switching and verify both survive.
- In List and Refresh List, select an item and move the pointer to a different row. The selected row keeps its short blue leading bar while the hovered row gains a neutral backplate. Expand a tree, sort a column, open its filter, and refresh the view.
- In Control / TextBox, focus an input, type, select text, move focus and disable the input. Check its accent underline, caret, selection contrast and disabled appearance. Repeat in both document editors, including nested menus, formatting, clipboard, hyperlink, image, dialog and save/reload operations.
- Exercise checked and unchecked boxes and radios by keyboard and pointer. Selected options have a filled accent face with a contrasting glyph or center. Their labels keep the ordinary foreground. Check enabled and disabled options.
- In Layout / Repeat, move both trackers and scrollbars, hover and drag each thumb, and inspect the progress bar at zero, partway and full. Thumb movement and the accent track must agree. Disabled scrollbars hide their thumbs.
- Resize both editors and inspect collapsed groups, independent split arrows, gallery paging, selected tabs and keytips. Open and dismiss menus, submenus, tooltips, combo and calendar popups and modal windows. Check input restoration.
- Visit the remaining Layout, Control and Misc pages, including localization and the raw graphics samples. Follow the showcase procedure through Exit.
