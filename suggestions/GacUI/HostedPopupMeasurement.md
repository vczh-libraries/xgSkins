# Hosted menus can open with stale or empty bounds

A hosted menu can contain measured rows while its window or frame still clips them.

## Repro

Open **Control / Document Editor (Toolstrip) / File** in
`FullControlTest /D2D /Hosted`. Compare the popup bounds, border bounds and text
rectangles in the automation service’s `Controls` tree. Repeat after switching to a
light skin and back to DarkSkin.

In an unmodified Release showcase, the File popup reported zero width and height even though its menu rows existed.
After a round trip to DarkSkin in the rebuilt Debug showcase, the same popup
reported a 1-by-1 window with measured text outside its clip. Resizing the
owner while the popup was open gave it a 201-by-56 rectangle.

## Workaround

Resize the owner by one pixel with the menu open and recheck its frame, fill, row
colors and bounds. This also made some Win8Skin popup and tab checks usable. Windows
UI Automation could expand File and its Save as submenu directly.

## Root Cause

Unknown. The outer popup and its contents can disagree about measured size. The
problem also occurred in an unmodified Release showcase.
[Related owner-window observation](ThemeRefreshLayoutReadiness.md).

## Proposal

Trace invalidation and measurement for hidden, reopened and newly retemplated popup
windows. Cover a round trip between themes at a fixed owner size. Once the popup
appears, its frame should enclose its measured rows and pointer hits should reach
those rows.
