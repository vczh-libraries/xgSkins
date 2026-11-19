# Windows 11 control motion

Pushbuttons and combo boxes interpolate their outline, face and foreground for 120 ms when hovered, pressed, released or disabled. Checkbox and radio selection use the same transition for their fill and mark. Input focus adds the accent underline immediately while the editor frame and background settle over 120 ms.

Scrollbar arrows, scroll thumbs, slider thumbs and gallery paging buttons interpolate their colors over 120 ms. The scrollbar thumb widens under the pointer, and the center of a slider thumb grows on hover and contracts during a drag. Both changes in size follow the current input state immediately. Dragging updates the slider rail and the progress value directly.

Toolbar and ribbon commands, including ribbon split arrows, use the button color transition. The ordinary toolbar split-arrow separator appears on hover or press. Group-box captions interpolate the enabled or disabled foreground over 120 ms. A new transition cancels the previous animation and starts at its current color.

List and gallery items, tree expanders, dates, headers, tabs, contextual indicators, menu rows, caption buttons, keytips and popup surfaces update directly. Document selection, the caret, command dispatch, popup placement and keyboard focus follow the control state. Composite templates inherit the behavior of their children.

Check a rapid enter, press, drag outside and release in both palettes. The resulting color should match the latest state and the action should execute once. See [the page mapping](TestGuidance.md).
