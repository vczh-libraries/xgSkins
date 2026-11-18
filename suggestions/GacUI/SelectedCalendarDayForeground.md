# Calendar day labels have no selected foreground

The common date-picker look applies the month’s foreground to a selected day even when
its button paints a different selection background.

## Repro

Select WinXPSkin in `FullControlTest /D2D /Hosted`, open **Misc / DatePicker** and
select a day. Inspect the day label and its button background in the `Controls` tree.
Compare current- and adjacent-month labels. Selection changes the button face while
the label uses the corresponding month color.

## Workaround

WinXPSkin uses a pale blue selected-day fill and blue border so that both month colors
remain legible. [XP palette notes](../../doc/WinXPSkin.md).

## Root Cause

`GuiCommonDatePickerLook` owns the day labels. Its `SetDay` assigns the current- or
adjacent-month text color independently of the day button’s selected state. The
`DateButtonTemplate` owns the button background and focus rectangle.
[<GacUI-repo>/Source/Controls/Templates/GuiCommonTemplates.cpp](https://github.com/vczh-libraries/GacUI/blob/master/Source/Controls/Templates/GuiCommonTemplates.cpp).

## Proposal

Give the common date-picker look a selected-day foreground input and retain the
existing month colors for ordinary days. Check selection, focus, disabled state and
theme changes on current- and adjacent-month days.
[Related graphical list issue](SelectedItemForeground.md).
