# Win7Skin test guidance

Create a fresh `FullControlTest /D2D /Hosted` session. It must start with
DarkSkin. Select `Win7Skin` under `Window Manager / Color Theme`; there is one
Win7Skin entry and no alternate Win7Skin color theme. The application state must
survive switching between the skins.

The paths below use visible tab captions. A modal or popup named after a page is
opened from that page. They identify the minimum affected pages when a template
changes; creating the skin requires the full showcase verification described in
[Project.md](../../Project.md), including the applicable operations in
`<GacUI-repo>/.github/Jobs/DebugRemoteProtocolSop.md`.

## Instance-to-page mapping

- win7skin::Theme: Window Manager, List / TextList, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Repeat, Misc / DatePicker.
- win7skin::CustomControlTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Responsive, Misc / TouchingList.
- win7skin::TooltipTemplate: Control / Document Editor (Ribbon).
- win7skin::SystemFrameWindowTemplate: Window Manager, Misc / Dialogs.
- win7skin::CustomFrameWindowTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- win7skin::CaptionButtonTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- win7skin::CaptionCloseButtonTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- win7skin::GroupBoxTemplate: List / TextList, Control / TextBox, Window Manager, Misc / Dialogs / FontDialog.
- win7skin::LabelTemplate: List / TextList, Layout / Easy Layout, Window Manager, Misc / Localization.
- win7skin::ShortcutKeyTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Window Manager.
- win7skin::DateButtonTemplate: Misc / DatePicker, List / BindableDataGrid.
- win7skin::DatePickerTemplate: Misc / DatePicker, List / BindableDataGrid.
- win7skin::ButtonTemplate: List / TextList, Layout / Easy Layout, Control / TextBox, Misc / Dialogs.
- win7skin::CheckBoxTemplate: List / TextList, Layout / Easy Layout, Control / TextBox, Misc / TouchingList.
- win7skin::RadioButtonTemplate: List / TextList, Window Manager.
- win7skin::DocumentLabelTemplate: Control / TextBox / Document, Control / Embedded Controls.
- win7skin::DocumentTextBoxTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Layout / Easy Layout.
- win7skin::DocumentViewerTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Control / Embedded Controls.
- win7skin::EditorBorderTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Easy Layout, List / TextList, List / ListView, List / TreeView.
- win7skin::TabHeaderButtonTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- win7skin::TabHeaderTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- win7skin::TabTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- win7skin::RibbonTabTemplate: Control / Document Editor (Ribbon).
- win7skin::ItemBackgroundTemplate: List / TextList, List / ListView, List / TreeView, List / BindableDataGrid, Control / Document Editor (Ribbon).
- win7skin::TextListTemplate: List / TextList, Refresh List / TextList, Refresh List / BindableTextList, Layout / Easy Layout.
- win7skin::ComboBoxTemplate: List / ListView, List / BindableDataGrid, Layout / Easy Layout, Misc / DatePicker, Misc / Localization.
- win7skin::ListViewColumnHeaderTemplate: List / ListView, List / BindableDataGrid, Refresh List / ListView, Refresh List / BindableDataGrid.
- win7skin::ListViewColumnDropDownTemplate: List / BindableDataGrid, Refresh List / BindableDataGrid.
- win7skin::ListViewTemplate: List / ListView, List / BindableDataGrid, Refresh List / ListView, Refresh List / BindableListView, Refresh List / BindableDataGrid.
- win7skin::ExpandingDecoratorTemplate: List / TreeView, Refresh List / TreeView, Refresh List / BindableTreeView, List / BindableDataGrid.
- win7skin::TreeViewTemplate: List / TreeView, Refresh List / TreeView, Refresh List / BindableTreeView, List / BindableDataGrid.
- win7skin::LeftScrollButtonTemplate: Layout / Repeat, List / ListView.
- win7skin::RightScrollButtonTemplate: Layout / Repeat, List / ListView.
- win7skin::TopScrollButtonTemplate: Layout / Repeat, List / TextList.
- win7skin::BottomScrollButtonTemplate: Layout / Repeat, List / TextList.
- win7skin::HScrollHandleTemplate: Layout / Repeat, List / ListView.
- win7skin::VScrollHandleTemplate: Layout / Repeat, List / TextList.
- win7skin::HTrackerHandleTemplate: Layout / Repeat.
- win7skin::VTrackerHandleTemplate: Layout / Repeat.
- win7skin::HScrollTemplate: Layout / Repeat, List / ListView, Control / TextBox.
- win7skin::VScrollTemplate: Layout / Repeat, List / TextList, Control / TextBox, Control / Document Editor (Ribbon).
- win7skin::HTrackerTemplate: Layout / Repeat.
- win7skin::VTrackerTemplate: Layout / Repeat.
- win7skin::ProgressBarTemplate: Layout / Repeat.
- win7skin::ScrollViewTemplate: Layout / Repeat, Layout / Responsive, Control / Embedded Controls, Misc / TouchingList.
- win7skin::ToolstripTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- win7skin::MenuBarTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- win7skin::ToolstripInMenuTemplate: Control / Document Editor (Ribbon).
- win7skin::ToolstripMenuTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), List / BindableDataGrid.
- win7skin::ToolstripSplitterTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win7skin::ToolstripSplitterInMenuTemplate: Control / Document Editor (Ribbon).
- win7skin::MenuSplitterTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip).
- win7skin::ToolstripButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win7skin::ToolstripDropdownButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win7skin::ToolstripSplitArrowTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win7skin::ToolstripSplitButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win7skin::MenuBarButtonTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- win7skin::MenuItemButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon), List / BindableDataGrid.
- win7skin::RibbonSmallButtonTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonSmallDropdownButtonTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonSmallSplitButtonTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonSmallSplitArrowTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonLargeButtonTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonLargeDropdownButtonTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonSplitArrowTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonLargeSplitButtonTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonSmallIconLabelTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonIconLabelTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonGroupTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonGroupExpandButtonTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonGroupMenuTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonButtonsTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonToolstripsTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonToolstripHeaderTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonGalleryTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonGalleryItemListTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonToolstripMenuTemplate: Control / Document Editor (Ribbon).
- win7skin::RibbonGalleryDropdownButtonTemplate: Control / Document Editor (Ribbon).

## Required observations

- On `Window Manager`, record the bounds of the seven window-option checkboxes
  and of the color-theme radio buttons with `DarkSkin` active. Switch to
  `Win7Skin` at the same client size and font. Each control should keep its
  width, height and position relative to the window client area, including
  the last row of each group.

- Switch from DarkSkin with the showcase already populated. Open the view selector
  in `List / ListView`, then `File / Save as` in the toolstrip editor. Check the
  thin popup frame, the resting row background, and the hover or selected row.
  Open `Object` in the editor context menu and check the same colors at both levels.
- In `Refresh List / TextList`, inspect both disabled scrollbars before moving
  the pointer onto either track. Only the track and arrows should be visible.
  In `Layout / Repeat`, drag both enabled thumbs and check their positions.
- In the ribbon editor, move onto a command and back out halfway through its
  hover transition. The yellow highlight should fade over the current surface
  in both directions without a dark frame.

- Check light surfaces, dark text, distinct disabled text, blue interaction
  states and green progress. Check keyboard focus and selected states as well
  as hover. Inspect the visible result, not only successful event dispatch.
- In `Layout / Repeat`, move both trackers and scrollbar thumbs, use all four
  arrow buttons, and check progress at zero, an intermediate value and full.
- In both document editors, execute the SOP editing, formatting, context-menu,
  dialog, image, hyperlink and save/reload checks. Resize the ribbon until
  groups collapse; check large, small and icon presentations, split-button
  regions, gallery dropdowns, all gallery choices, group expansion and keytips.
- Traverse every `Refresh List` page and verify that refreshed or newly
  realized items use the active skin. Verify checkbox/radio list styles and
  column-header sort/filter states independently.
- Open date, combo, menu, tooltip and modal popups. Check placement, clipping,
  dismissal and restored owner input. Check close, minimize, maximize and
  resize behavior wherever the window permits it. System-frame artwork is
  exercised only when a window requests that frame; a custom-frame hosted run
  alone does not demonstrate the system-frame template.
- Visit all `Layout` and `Misc` pages, including the responsive modal, raw
  clock, touch samples, animation, localization and all dialog categories.
  Existing sample-specific drawing is not redefined by the skin.
- Change a selected list item, editable text and a checkbox before switching
  `Win7Skin -> DarkSkin -> Win7Skin`; require preserved state, fresh colors and
  no duplicated popup or handler. Finish by closing through the `Exit` page.

Use the application automation service first and attempt Windows UI Automation
afterwards. Record unavailable desktop, physical touch or global-hotkey checks
separately. Renderer replacement, browser IME and other remote transport
operations apply only when those configurations are actually under test; they
are not implied by the required local hosted run.
