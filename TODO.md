# TODO

- `WinXPStyle`
  - Combo box triangle, is too thin causing the triangle to be too large.
- `WinXPStyle`, `WinVistaStyle`, `Win7Style`, `Win8Style`, `Win10Style`, `Win11Style`
  - Gallary navigation button, is too thin causing the triangle to be too large.
    - A solution is to extend the button 1 pixel both from the left and the right, also move it 1 pixel to the left, but adjust alignment between gallary/navigation/right border so that the gallary control does not get wider because of this.
    - `WinXPStyle` needs 2 pixels.
- `WinVistaStyle`, `Win7Style`, `Win8Style`, `Win10Style`, `Win11Style`
  - Tab headers has a gap to the tab page container. I think this might be affected by the `DarkSkin`, but you need to do another round of research about how it should look like by checking screenshots on the official document or from the internet, make it right.
    - It is OK that tab header height becomes different from `DarkSkin` because of the fix.
  - You should also calibrate the colors, for example, if you look at Windows 10's explorer with a light profile:
    - Ribbon hover/selected colors are a little bit darker.
    - Selected list item has a border.
    - Selected tab header's white area is joined with the container, aka the container has a border but the part sibiling with the tab header does not.
- `FullControlTest`: This part might need to fix in GacUI, I guess the issue happens because it is a `<SolidLabel/>` instead of `<Label/>` so that the skin color does not apply.
  - `Misc/Localization` label color.
  - `Misc/Dialog` label color.
- `Win10Style`, `Win11Style`
  - The arrow at the right side of the combo box should have one pixel to the border, they are stick to each other right now.
- `UbuntuStyle`
  - Ubuntu ribbon/menu has color mistakes. Need research.
  - Is ribbon header black?
  - Menu is black but menu item is white?
- Figure out how to make the vertical tab page align with skins:
  - `Layout` test page vertical tab page.
  - `Control/DocumentEditor (Ribbon)` gallary icon text color.
  - `Misc/RawClock` and `Misc/Touching` background.
  - `Misc/TouchingList` item template.
  - `Misc/Dialog/FontDialog` label color.
  - Each skin might need a standard protocol to expose color settings.
  - `<Label/>` should support font/color/size/effect settings, by exposing `Nullable<T>` properties.
- Vista and Win7 looks so similar is this intended?

## Doing

- Align control sizes across skins.
