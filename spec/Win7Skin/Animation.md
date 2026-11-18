# Win7Skin animation requirements

Win7Skin should retain the short color transitions of the original Windows 7
styles. Hover, press, release, focus and enabled-state changes must remain
responsive while a transition is running. A new state should interrupt the
current transition smoothly, without briefly returning to an older state.

## Animated states

- Pushbuttons, check boxes and radio buttons: blend the border, background,
  gradient and glyph colors over 120 milliseconds. Selection changes must not
  delay the actual checked state or its command.
- Scrollbar arrows, scrollbar thumbs and tracker thumbs: use the same
  120-millisecond state-color transition as pushbuttons. Scrolling and dragging
  must follow input immediately. Disabling a scrollbar hides its thumb at once.
- Combo boxes: blend the button colors over 120 milliseconds. Opening and
  closing the list must not wait for the color transition.
- Text boxes, document editors and the outer borders of list/tree controls:
  blend the border and background between normal, hovered, focused and disabled
  colors over 120 milliseconds. Text, caret, selection and scrolling must update
  immediately.
- Toolbar buttons and ribbon command buttons: blend state
  colors over 120 milliseconds while keeping command execution and submenu
  opening immediate. The ribbon extension uses the same transition timing as
  the legacy toolbar. The independent ribbon split-arrow regions
  (`RibbonSmallSplitArrowTemplate` and `RibbonSplitArrowTemplate`) also use
  this transition as part of the ribbon extension.
- Ribbon gallery dropdown buttons use the scrollbar-button colors and their
  120-millisecond transition. Gallery up/down buttons keep the same scrollbar
  behavior.
- Group-box captions: blend enabled and disabled text colors over
  120 milliseconds. The surrounding frame and layout do not animate.

## Immediate states

- Ordinary toolbar split-arrow regions (`ToolstripSplitArrowTemplate`) have a
  transparent face. Their two-pixel beveled separator appears immediately on
  enabled hover or press; the parent toolbar button retains its 120-millisecond
  face transition.

- List, tree and calendar-date item backgrounds change immediately on hover and
  selection.
- Tab headers change immediately on hover, selection and contextual highlighting.
- List-view column headers and tree expanders change immediately. Expanding a
  branch must not wait for a decorative rotation or fade.
- Menu-bar buttons, menu item selection, check marks and submenu arrows change
  immediately.
- Progress fill follows the current value immediately. A decorative sweep or
  indeterminate-progress animation is outside this skin's scope.
- Layout changes, gallery scrolling, popup creation and skin replacement must
  not acquire extra animation delays.
- Window captions, caption buttons, plain labels, keytips, tooltip surfaces,
  group frames, separators, calendar layout, ribbon group/header/icon-label
  surfaces and popup borders have no independent color animation. Composite
  controls retain the animated behavior of their button, editor or scroll
  children described above.

## Scope and verification

The skin does not add window opening, closing, resizing or compositor effects.
Application animations, the caret, tooltips and interaction timing remain the
responsibility of their existing controls.

Exercise every animated control through normal, hover, pressed, released and
disabled states where available. Move the pointer away midway through a
transition and verify that the final colors match the new state. Check selected
controls independently of hover. Repeat after switching from DarkSkin to
Win7Skin and after reopening a popup. Use the pages listed in
[TestGuidance.md](TestGuidance.md); animation colors must agree with
[ColorPackage.md](ColorPackage.md).
