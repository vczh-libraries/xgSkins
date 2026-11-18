# WinXPSkin test guidance

Create a fresh `FullControlTest /D2D /Hosted` session. It must start with
DarkSkin. Select `WinXPSkin` under `Window Manager / Color Theme`; there is one
WinXPSkin entry and no alternate WinXPSkin color theme. The application state must
survive switching between the skins.

The paths below use visible tab captions. A modal or popup named after a page is
opened from that page. They identify the minimum affected pages when a template
changes; creating the skin requires the full showcase verification described in
[Project.md](../../Project.md), including the applicable operations in
`<GacUI-repo>/.github/Jobs/DebugRemoteProtocolSop.md`.

## Instance-to-page mapping

- winxpskin::Theme: Window Manager, List / TextList, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Repeat, Misc / DatePicker.
- winxpskin::CustomControlTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Responsive, Misc / TouchingList.
- winxpskin::TooltipTemplate: Control / Document Editor (Ribbon).
- winxpskin::SystemFrameWindowTemplate: Window Manager, Misc / Dialogs.
- winxpskin::CustomFrameWindowTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- winxpskin::CaptionButtonTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- winxpskin::CaptionCloseButtonTemplate: Window Manager, Layout / Easy Layout (Responsive), Misc / Dialogs.
- winxpskin::GroupBoxTemplate: List / TextList, Control / TextBox, Window Manager.
- winxpskin::LabelTemplate: List / TextList, Layout / Easy Layout, Window Manager, Misc / Localization.
- winxpskin::ShortcutKeyTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Window Manager.
- winxpskin::DateButtonTemplate: Misc / DatePicker, List / BindableDataGrid.
- winxpskin::DatePickerTemplate: Misc / DatePicker, List / BindableDataGrid.
- winxpskin::ButtonTemplate: List / TextList, Layout / Easy Layout, Control / TextBox, Misc / Dialogs.
- winxpskin::CheckBoxTemplate: List / TextList, Layout / Easy Layout, Control / TextBox, Misc / TouchingList.
- winxpskin::RadioButtonTemplate: List / TextList, Window Manager.
- winxpskin::DocumentLabelTemplate: Control / TextBox / Document, Control / Embedded Controls.
- winxpskin::DocumentTextBoxTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Layout / Easy Layout.
- winxpskin::DocumentViewerTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Control / Embedded Controls.
- winxpskin::EditorBorderTemplate: Control / TextBox / TextBox, Control / TextBox / Document, Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), Layout / Easy Layout, List / TextList, List / ListView, List / TreeView.
- winxpskin::TabHeaderButtonTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- winxpskin::TabHeaderTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- winxpskin::TabTemplate: List / TextList, Control / TextBox, Control / Document Editor (Ribbon), Misc / Animation.
- winxpskin::RibbonTabTemplate: Control / Document Editor (Ribbon).
- winxpskin::ItemBackgroundTemplate: List / TextList, List / ListView, List / TreeView, List / BindableDataGrid, Control / Document Editor (Ribbon).
- winxpskin::TextListTemplate: List / TextList, Refresh List / TextList, Refresh List / BindableTextList, Layout / Easy Layout.
- winxpskin::ComboBoxTemplate: List / ListView, List / BindableDataGrid, Layout / Easy Layout, Misc / DatePicker, Misc / Localization.
- winxpskin::ListViewColumnHeaderTemplate: List / ListView, List / BindableDataGrid, Refresh List / ListView, Refresh List / BindableDataGrid.
- winxpskin::ListViewColumnDropDownTemplate: List / BindableDataGrid, Refresh List / BindableDataGrid.
- winxpskin::ListViewTemplate: List / ListView, List / BindableDataGrid, Refresh List / ListView, Refresh List / BindableListView, Refresh List / BindableDataGrid.
- winxpskin::ExpandingDecoratorTemplate: List / TreeView, Refresh List / TreeView, Refresh List / BindableTreeView, List / BindableDataGrid.
- winxpskin::TreeViewTemplate: List / TreeView, Refresh List / TreeView, Refresh List / BindableTreeView, List / BindableDataGrid.
- winxpskin::LeftScrollButtonTemplate: Layout / Repeat, List / ListView.
- winxpskin::RightScrollButtonTemplate: Layout / Repeat, List / ListView.
- winxpskin::TopScrollButtonTemplate: Layout / Repeat, List / TextList.
- winxpskin::BottomScrollButtonTemplate: Layout / Repeat, List / TextList.
- winxpskin::HScrollHandleTemplate: Layout / Repeat, List / ListView.
- winxpskin::VScrollHandleTemplate: Layout / Repeat, List / TextList.
- winxpskin::HTrackerHandleTemplate: Layout / Repeat.
- winxpskin::VTrackerHandleTemplate: Layout / Repeat.
- winxpskin::HScrollTemplate: Layout / Repeat, List / ListView, Control / TextBox.
- winxpskin::VScrollTemplate: Layout / Repeat, List / TextList, Control / TextBox, Control / Document Editor (Ribbon).
- winxpskin::HTrackerTemplate: Layout / Repeat.
- winxpskin::VTrackerTemplate: Layout / Repeat.
- winxpskin::ProgressBarTemplate: Layout / Repeat.
- winxpskin::ProgressChunkTemplate: Layout / Repeat.
- winxpskin::ScrollViewTemplate: Layout / Repeat, Layout / Responsive, Control / Embedded Controls, Misc / TouchingList.
- winxpskin::ToolstripTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- winxpskin::MenuBarTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- winxpskin::ToolstripInMenuTemplate: Control / Document Editor (Ribbon).
- winxpskin::ToolstripMenuTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip), List / BindableDataGrid.
- winxpskin::ToolstripSplitterTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- winxpskin::ToolstripSplitterInMenuTemplate: Control / Document Editor (Ribbon).
- winxpskin::MenuSplitterTemplate: Control / Document Editor (Ribbon), Control / Document Editor (Toolstrip).
- winxpskin::ToolstripButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- winxpskin::ToolstripDropdownButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- winxpskin::ToolstripSplitArrowTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- winxpskin::ToolstripSplitButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon).
- winxpskin::MenuBarButtonTemplate: Control / Document Editor (Toolstrip), Layout / Easy Layout (Responsive).
- winxpskin::MenuItemButtonTemplate: Control / Document Editor (Toolstrip), Control / Document Editor (Ribbon), List / BindableDataGrid.
- winxpskin::RibbonSmallButtonTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonSmallDropdownButtonTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonSmallSplitButtonTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonSmallSplitArrowTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonLargeButtonTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonLargeDropdownButtonTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonSplitArrowTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonLargeSplitButtonTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonSmallIconLabelTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonIconLabelTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonSplitterTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonGroupTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonGroupExpandButtonTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonGroupMenuTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonButtonsTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonToolstripsTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonToolstripHeaderTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonGalleryTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonGalleryItemListTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonToolstripMenuTemplate: Control / Document Editor (Ribbon).
- winxpskin::RibbonGalleryDropdownButtonTemplate: Control / Document Editor (Ribbon).

## Required observations

- Check beige clients, cream button faces, subtly rounded borders, dark text,
  muted disabled text, orange hover accents, blue scrollbars and segmented green
  progress. Check the blue pushbutton focus rim and dotted keyboard-focus
  rectangles separately from hover. Inspect the visible result, not only
  successful event dispatch.
  Disabled document-based editors retain their configured text colors; check
  the gray-beige fill and blue-gray border without expecting a gray text override.
- In `Layout / Repeat`, move both trackers and scrollbar thumbs, use all four
  17-pixel square arrow buttons, and check progress at zero, an intermediate
  value and full. Progress chunks are six pixels wide with two-pixel gaps; the
  final partial chunk must stay inside the track. Check the pointed horizontal
  tracker thumb and rectangular vertical thumb, including their disabled state.
  Change progress rapidly, resize its owner and switch skins with an update
  pending; require the latest value, valid geometry and safe template teardown.
- Check rounded tab tops and orange selected/hot edges, boxed plus/minus tree
  expanders, white combo content with a separate blue arrow button, and white
  menu rows with blue/white hot selection. List and calendar selection uses a
  pale blue face and blue outline so framework-owned dark labels remain legible.
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
  `WinXPSkin -> Win7Skin -> Win8Skin -> DarkSkin -> WinXPSkin`; require preserved state, fresh colors and
  no duplicated popup or handler. Finish by closing through the `Exit` page.

Use the application automation service first and attempt Windows UI Automation
afterwards. Record unavailable desktop, physical touch or global-hotkey checks
separately. Renderer replacement, browser IME and other remote transport
operations apply only when those configurations are actually under test; they
are not implied by the required local hosted run.
