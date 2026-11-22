# UbuntuSkin animation

The skin interpolates the following colors over 150 ms. A new transition starts at the current paint value. The final frame applies the target color exactly. [GacUI animation endpoint](../../suggestions/GacUI/FiniteAnimationEndpoint.md).

| Templates | Animated properties |
| --- | --- |
| Pushbuttons and combo boxes | Border, face, label and arrow on hover, press, opening and enablement. |
| Checkboxes and radio buttons | Indicator border, fill, mark and label on selection, hover, press and enablement. |
| Text fields, rich-document views, lists and trees | Frame and field colors on hover, focus and re-enabling. Disabling a control applies its palette immediately. Text fields also apply their backdrop colors as soon as their window becomes inactive and animate back on activation. |
| Horizontal and vertical scale handles and scrollbar thumbs | Rim and face on hover, drag and release. Position follows the pointer directly. |
| Toolbar and ribbon command buttons, ribbon split arrows and gallery arrows | Frame, face, label and arrow on hover, press, selection, opening and enablement. |
| Group captions | Text on enablement changes. |

Window activation, caption discs and glyphs, tab rules, menu highlights, toolbar split dividers, list rows, column sorting, tree expansion, calendar cells, keyboard focus outlines and access keys respond immediately. Progress and scale fills track their current values. GacUI controls popup, tooltip and page timing.
