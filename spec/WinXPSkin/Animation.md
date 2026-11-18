# WinXPSkin state and animation requirements

WinXPSkin should provide immediate visual feedback in the style of the default
blue Windows XP controls. Hover, press, release, selection, focus and disabled
states must not wait for a decorative color fade. A rapid state change must
display the newest applicable palette immediately, without applying an older
target later.

## Immediate skin states

- Pushbuttons, check boxes, radio buttons and combo boxes update their borders,
  inner accents, faces, text and marks immediately.
- Scrollbar arrows/thumbs and tracker thumbs update their states immediately.
  Disabling a scrollbar hides its thumb at once. Pointer movement, scrolling
  and dragging remain governed by the controls.
- Editor and list/tree borders and backgrounds update focus and enabled-state
  colors immediately. Document foregrounds retain their configured colors;
  caret, text, selection and scrolling remain responsive.
- Ordinary and ribbon tabs, column headers, tree expanders, item backgrounds
  and calendar-date feedback change immediately. Expansion has no decorative
  rotation or delay.
- Menus, toolbars and invented ribbon commands apply state colors immediately.
  Opening, closing, selection and command execution must not acquire a delay.
- Group captions, labels, keytips, tooltip surfaces, separators and custom-frame
  captions/buttons have no independent skin animation.
- Determinate progress changes its green chunk coverage with the current value.
  A decorative moving highlight or indeterminate marquee is outside this
  template's scope. Rebuilding chunks may wait for the current layout traversal
  to finish safely; the update must use the latest value and must not access a
  destroyed template. This is a structural scheduling requirement, not a visual
  animation.

## Scope and verification

The skin does not add window opening, closing, resizing or compositor effects.
Existing application animations, tooltip delays, caret timing and control input
behavior remain intact. Immediate state changes are the reconstruction's
explicit policy; they are not a claim that every Windows XP feature was static.

Exercise every stateful control through normal, hover, press, release, focus,
selection and disabled states where available. Require the current exact
palette values after each change, including when the pointer reverses rapidly.
Check selected states separately from hover, then repeat after replacing the
skin and after reopening popups. Use
[TestGuidance.md](TestGuidance.md) to select affected pages; state colors must
agree with [ColorPackage.md](ColorPackage.md).
