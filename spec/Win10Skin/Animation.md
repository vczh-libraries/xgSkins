# Windows 10 interaction states

The Windows 10 SDK uses discrete brush changes for the pointer and selection states of its square controls. Win10Skin applies those colors on the event frame so that rapid presses, drags and theme switches display the current state. The light and dark packages use identical timing.

| Controls or items | Visible response |
| --- | --- |
| Pushbutton, combo and input border | Hover changes the outline. Pressing darkens or lightens the button fill. Focus applies the input accent outline immediately. |
| Checkbox and radio button, including list bullets | Selecting toggles the check or inner dot on the input frame. Hover and press update the enclosing stroke and fill. |
| Calendar days, lists, column headers and trees | Pointer-over changes the row fill. Selection colors the row. Expanding switches the chevron direction as the child rows appear. |
| Tab and ribbon headers | The selected underline moves to the newly selected page immediately. Contextual ribbon headers also show their top strip. |
| Menu, toolbar and ribbon commands | Hover, press, toggle and open-submenu states change the face and glyph together. Split buttons have distinct main and arrow hit targets. |
| Slider, scrollbar and progress | Thumbs follow dragging directly, and the filled portion follows the current value. Arrow buttons and thumbs apply their hover and pressed colors immediately. |
| Window captions, tooltip, keytip, group box, labels and dividers | Activation, enabled state and hover update their colors directly. Each surface stays in place. |

Popup placement, modal activation, caret blinking, tab changes and application-authored animations use the timing supplied by GacUI or the application. For both palettes, exercise interrupted input by pressing a button, dragging away and releasing. Its final fill and foreground should match the pointer location and enabled state.
