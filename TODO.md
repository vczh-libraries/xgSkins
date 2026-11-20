# TODO

In `Control/DocumentEditor (Ribbon)` you can see gallary icon text colors are hardcoded white if color is not assigned.
I think this is incorrect, you can use `<Label/>` to replace it, so that when color is not assigned, it has the default color.
Fix `FullControlTest` in GacUI and import to this repo. Verify if that works.
Delete suggestions that resolved by this task.
commit and push once finishing.

- `UbuntuStyle`
  - Ubuntu ribbon/menu has color mistakes. Need research.
  - Is ribbon header black?
  - Menu is black but menu item is white?
- Figure out how to make the vertical tab page align with skins:
  - `Layout` test page vertical tab page.
  - `Misc/RawClock` and `Misc/Touching` background.
  - `Misc/TouchingList` item template.
  - Each skin might need a standard protocol to expose color settings.
- Figure out how to make window frame border in skin thinner, DarkTide's Left/Right/Bottom border is visually forced a distance between the border to the container, but other skins fill the whole gap, making like OK/Cancel button stick to the right/bottom corner without gap.
