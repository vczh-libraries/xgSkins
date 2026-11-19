# WinVistaSkin test guidance

Create a fresh `FullControlTest /D2D /Hosted` session. It must start with
DarkSkin. Select `WinVistaSkin` under `Window Manager / Color Theme`; there is one
WinVistaSkin entry and no alternate WinVistaSkin color theme. The application state must
survive switching between the skins.

The paths below use visible tab captions. A modal or popup named after a page is
opened from that page. They identify the minimum affected pages when a template
changes; creating the skin requires the full showcase verification described in
[Project.md](../../Project.md), including the applicable operations in
`<GacUI-repo>/.github/Jobs/DebugRemoteProtocolSop.md`.

## Instance-to-page mapping

- winvistaskin::Theme: Window Manager, List / TextList, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Repeat, Misc / DatePicker.
- winvistaskin::CustomControlTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Responsive, Misc / TouchingList.
- winvistaskin::TooltipTemplate: Control / Document Editor (Ribbon).
- winvistaskin::SystemFrameWindowTemplate: Window Manager, Misc / Dialogs.
- winvistaskin::CustomFrameWindowTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- winvistaskin::CaptionButtonTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- winvistaskin::CaptionCloseButtonTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- winvistaskin::GroupBoxTemplate: List / TextList, Control / TextBox, Window Manager.
- winvistaskin::LabelTemplate: List / TextList, Layout / Easy Layout, Window Manager, Misc / Localization.
- winvistaskin::ShortcutKeyTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Window Manager.
- winvistaskin::DateButtonTemplate: Misc / DatePicker, List / BindableDataGrid.
- winvistaskin::DatePickerTemplate: Misc / DatePicker, List / BindableDataGrid.
- winvistaskin::ButtonTemplate: List / TextList, Layout / Easy Layout, Control / TextBox, Misc / Dialogs.
- winvistaskin::CheckBoxTemplate: List / TextList, Layout / Easy Layout, Control / TextBox, Misc / TouchingList.
- winvistaskin::RadioButtonTemplate: List / TextList, Window Manager.
- winvistaskin::DocumentLabelTemplate: Control / TextBox / Document, Control / Embedded Controls.
- winvistaskin::DocumentTextBoxTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Layout / Easy Layout.
- winvistaskin::DocumentViewerTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Control / Embedded Controls.
- winvistaskin::EditorBorderTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Easy Layout, List / TextList, List / ListView, List / TreeView.
- winvistaskin::TabHeaderButtonTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- winvistaskin::TabHeaderTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- winvistaskin::TabTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- winvistaskin::RibbonTabTemplate: Control / Document Editor (Ribbon).
- winvistaskin::ItemBackgroundTemplate: List / TextList, List / ListView, List / TreeView, List / BindableDataGrid, Control / Document Editor (Ribbon).
- winvistaskin::TextListTemplate: List / TextList, Refresh List / TextList, Refresh List / BindableTextList, Layout / Easy Layout.
- winvistaskin::ComboBoxTemplate: List / ListView, List / BindableDataGrid, Layout / Easy Layout, Misc / DatePicker, Misc / Localization.
- winvistaskin::ListViewColumnHeaderTemplate: List / ListView, List / BindableDataGrid, Refresh List / ListView, Refresh List / BindableDataGrid.
- winvistaskin::ListViewColumnDropDownTemplate: List / BindableDataGrid, Refresh List / BindableDataGrid.
- winvistaskin::ListViewTemplate: List / ListView, List / BindableDataGrid, Refresh List / ListView, Refresh List / BindableListView, Refresh List / BindableDataGrid.
- winvistaskin::ExpandingDecoratorTemplate: List / TreeView, Refresh List / TreeView, Refresh List / BindableTreeView, List / BindableDataGrid.
- winvistaskin::TreeViewTemplate: List / TreeView, Refresh List / TreeView, Refresh List / BindableTreeView, List / BindableDataGrid.
- winvistaskin::LeftScrollButtonTemplate: Layout / Repeat, List / ListView.
- winvistaskin::RightScrollButtonTemplate: Layout / Repeat, List / ListView.
- winvistaskin::TopScrollButtonTemplate: Layout / Repeat, List / TextList.
- winvistaskin::BottomScrollButtonTemplate: Layout / Repeat, List / TextList.
- winvistaskin::HScrollHandleTemplate: Layout / Repeat, List / ListView.
- winvistaskin::VScrollHandleTemplate: Layout / Repeat, List / TextList.
- winvistaskin::HTrackerHandleTemplate: Layout / Repeat.
- winvistaskin::VTrackerHandleTemplate: Layout / Repeat.
- winvistaskin::HScrollTemplate: Layout / Repeat, List / ListView, Control / TextBox.
- winvistaskin::VScrollTemplate: Layout / Repeat, List / TextList, Control / TextBox, Control / Document Editor (Ribbon).
- winvistaskin::HTrackerTemplate: Layout / Repeat.
- winvistaskin::VTrackerTemplate: Layout / Repeat.
- winvistaskin::ProgressBarTemplate: Layout / Repeat.
- winvistaskin::ScrollViewTemplate: Layout / Repeat, Layout / Responsive, Control / Embedded Controls, Misc / TouchingList.
- winvistaskin::ToolstripTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- winvistaskin::MenuBarTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- winvistaskin::ToolstripInMenuTemplate: Control / Document Editor (Ribbon).
- winvistaskin::ToolstripMenuTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), List / BindableDataGrid.
- winvistaskin::ToolstripSplitterTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- winvistaskin::ToolstripSplitterInMenuTemplate: Control / Document Editor (Ribbon).
- winvistaskin::MenuSplitterTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip).
- winvistaskin::ToolstripButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- winvistaskin::ToolstripDropdownButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- winvistaskin::ToolstripSplitArrowTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- winvistaskin::ToolstripSplitButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- winvistaskin::MenuBarButtonTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- winvistaskin::MenuItemButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon), List / BindableDataGrid.
- winvistaskin::RibbonSmallButtonTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonSmallDropdownButtonTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonSmallSplitButtonTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonSmallSplitArrowTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonLargeButtonTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonLargeDropdownButtonTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonSplitArrowTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonLargeSplitButtonTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonSmallIconLabelTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonIconLabelTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonGroupTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonGroupExpandButtonTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonGroupMenuTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonButtonsTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonToolstripsTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonToolstripHeaderTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonGalleryTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonGalleryItemListTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonToolstripMenuTemplate: Control / Document Editor (Ribbon).
- winvistaskin::RibbonGalleryDropdownButtonTemplate: Control / Document Editor (Ribbon).

## Required observations

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

- Check the blue glass caption, white caption glyphs, red close button, light surfaces, dark text, distinct disabled text, blue interaction
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
  `WinVistaSkin -> DarkSkin -> WinVistaSkin`; require preserved state, fresh colors and
  no duplicated popup or handler. Finish by closing through the `Exit` page.

Use the application automation service first and attempt Windows UI Automation
afterwards. Record unavailable desktop, physical touch or global-hotkey checks
separately. Renderer replacement, browser IME and other remote transport
operations apply only when those configurations are actually under test; they
are not implied by the required local hosted run.
