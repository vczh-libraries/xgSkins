# Win8Skin test guidance

Create a fresh `FullControlTest /D2D /Hosted` session. It must start with
DarkSkin. Select `Win8Skin` under `Window Manager / Color Theme`; there is one
Win8Skin entry and no alternate Win8Skin color theme. The application state must
survive switching between the skins.

The paths below use visible tab captions. A modal or popup named after a page is
opened from that page. They identify the minimum affected pages when a template
changes; creating the skin requires the full showcase verification described in
[Project.md](../../Project.md), including the applicable operations in
`<GacUI-repo>/.github/Jobs/DebugRemoteProtocolSop.md`.

## Instance-to-page mapping

- win8skin::Theme: Window Manager, List / TextList, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Repeat, Misc / DatePicker.
- win8skin::CustomControlTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Responsive, Misc / TouchingList.
- win8skin::TooltipTemplate: Control / Document Editor (Ribbon).
- win8skin::SystemFrameWindowTemplate: Window Manager, Misc / Dialogs.
- win8skin::CustomFrameWindowTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- win8skin::CaptionButtonTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- win8skin::CaptionCloseButtonTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- win8skin::GroupBoxTemplate: List / TextList, Control / TextBox, Window Manager, Misc / Dialogs / FontDialog.
- win8skin::LabelTemplate: List / TextList, Layout / Easy Layout, Window Manager, Misc / Localization.
- win8skin::ShortcutKeyTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Window Manager.
- win8skin::DateButtonTemplate: Misc / DatePicker, List / BindableDataGrid.
- win8skin::DatePickerTemplate: Misc / DatePicker, List / BindableDataGrid.
- win8skin::ButtonTemplate: List / TextList, Layout / Easy Layout, Control / TextBox, Misc / Dialogs.
- win8skin::CheckBoxTemplate: List / TextList, Layout / Easy Layout, Control / TextBox, Misc / TouchingList.
- win8skin::RadioButtonTemplate: List / TextList, Window Manager.
- win8skin::DocumentLabelTemplate: Control / TextBox / Document, Control / Embedded Controls.
- win8skin::DocumentTextBoxTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Layout / Easy Layout.
- win8skin::DocumentViewerTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Control / Embedded Controls.
- win8skin::EditorBorderTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Easy Layout, List / TextList, List / ListView, List / TreeView.
- win8skin::TabHeaderButtonTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- win8skin::TabHeaderTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- win8skin::TabTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- win8skin::RibbonTabTemplate: Control / Document Editor (Ribbon).
- win8skin::ItemBackgroundTemplate: List / TextList, List / ListView, List / TreeView, List / BindableDataGrid, Control / Document Editor (Ribbon).
- win8skin::TextListTemplate: List / TextList, Refresh List / TextList, Refresh List / BindableTextList, Layout / Easy Layout.
- win8skin::ComboBoxTemplate: List / ListView, List / BindableDataGrid, Layout / Easy Layout, Misc / DatePicker, Misc / Localization.
- win8skin::ListViewColumnHeaderTemplate: List / ListView, List / BindableDataGrid, Refresh List / ListView, Refresh List / BindableDataGrid.
- win8skin::ListViewColumnDropDownTemplate: List / BindableDataGrid, Refresh List / BindableDataGrid.
- win8skin::ListViewTemplate: List / ListView, List / BindableDataGrid, Refresh List / ListView, Refresh List / BindableListView, Refresh List / BindableDataGrid.
- win8skin::ExpandingDecoratorTemplate: List / TreeView, Refresh List / TreeView, Refresh List / BindableTreeView, List / BindableDataGrid.
- win8skin::TreeViewTemplate: List / TreeView, Refresh List / TreeView, Refresh List / BindableTreeView, List / BindableDataGrid.
- win8skin::LeftScrollButtonTemplate: Layout / Repeat, List / ListView.
- win8skin::RightScrollButtonTemplate: Layout / Repeat, List / ListView.
- win8skin::TopScrollButtonTemplate: Layout / Repeat, List / TextList.
- win8skin::BottomScrollButtonTemplate: Layout / Repeat, List / TextList.
- win8skin::HScrollHandleTemplate: Layout / Repeat, List / ListView.
- win8skin::VScrollHandleTemplate: Layout / Repeat, List / TextList.
- win8skin::HTrackerHandleTemplate: Layout / Repeat.
- win8skin::VTrackerHandleTemplate: Layout / Repeat.
- win8skin::HScrollTemplate: Layout / Repeat, List / ListView, Control / TextBox.
- win8skin::VScrollTemplate: Layout / Repeat, List / TextList, Control / TextBox, Control / Document Editor (Ribbon).
- win8skin::HTrackerTemplate: Layout / Repeat.
- win8skin::VTrackerTemplate: Layout / Repeat.
- win8skin::ProgressBarTemplate: Layout / Repeat.
- win8skin::ScrollViewTemplate: Layout / Repeat, Layout / Responsive, Control / Embedded Controls, Misc / TouchingList.
- win8skin::ToolstripTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- win8skin::MenuBarTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- win8skin::ToolstripInMenuTemplate: Control / Document Editor (Ribbon).
- win8skin::ToolstripMenuTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), List / BindableDataGrid.
- win8skin::ToolstripSplitterTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win8skin::ToolstripSplitterInMenuTemplate: Control / Document Editor (Ribbon).
- win8skin::MenuSplitterTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip).
- win8skin::ToolstripButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win8skin::ToolstripDropdownButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win8skin::ToolstripSplitArrowTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win8skin::ToolstripSplitButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- win8skin::MenuBarButtonTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- win8skin::MenuItemButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon), List / BindableDataGrid.
- win8skin::RibbonSmallButtonTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonSmallDropdownButtonTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonSmallSplitButtonTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonSmallSplitArrowTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonLargeButtonTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonLargeDropdownButtonTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonSplitArrowTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonLargeSplitButtonTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonSmallIconLabelTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonIconLabelTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonSplitterTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonGroupTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonGroupExpandButtonTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonGroupMenuTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonButtonsTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonToolstripsTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonToolstripHeaderTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonGalleryTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonGalleryItemListTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonToolstripMenuTemplate: Control / Document Editor (Ribbon).
- win8skin::RibbonGalleryDropdownButtonTemplate: Control / Document Editor (Ribbon).

## Required observations

- On `Window Manager`, record the bounds of the seven window-option checkboxes
  and of the color-theme radio buttons with `DarkSkin` active. Switch to
  `Win8Skin` at the same client size and font. Each control should keep its
  width, height and position relative to the window client area, including
  the last row of each group.

- Switch from DarkSkin with the showcase already populated. Open the view selector
  in `List / ListView`, then `File / Save as` in the toolstrip editor. Check the
  thin popup frame, the resting row background, and the hover or selected row.
  Open `Object` in the editor context menu and check the same colors at both levels.
- In `Refresh List / TextList`, inspect both disabled scrollbars before moving
  the pointer onto either track. Only the track and arrows should be visible.
  In `Layout / Repeat`, drag both enabled thumbs and check their positions.
- Repeat the disabled scrollbar check after switching from Win7Skin to Win8Skin.
  Resting menu rows should blend into the popup background up to their edges.

- Check flat light surfaces, square outlines, dark text, distinct disabled text,
  blue interaction states, gray scrollbars and solid green progress. Check keyboard focus and selected states as well
  as hover. Inspect the visible result, not only successful event dispatch.
- In `Layout / Repeat`, move both trackers and scrollbar thumbs, use all four
  arrow buttons, and check progress at zero, an intermediate value and full.
  Compare the scrollbar gutter and thumb travel at both endpoints with DarkSkin.
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
  `Win8Skin -> Win7Skin -> DarkSkin -> Win8Skin`; require preserved state, fresh colors and
  no duplicated popup or handler. Finish by closing through the `Exit` page.

Use the application automation service first and attempt Windows UI Automation
afterwards. Record unavailable desktop, physical touch or global-hotkey checks
separately. Renderer replacement, browser IME and other remote transport
operations apply only when those configurations are actually under test; they
are not implied by the required local hosted run.
