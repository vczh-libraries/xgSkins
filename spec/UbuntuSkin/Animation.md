# UbuntuSkin animation

The following state changes interpolate colors for 150 ms. Changing direction during a fade starts a transition from the current paint. When a transition completes it paints its target exactly. [Yaru widget styling](https://github.com/ubuntu/yaru/blob/26.04.5.1ubuntu/gtk/src/default/gtk-3.0/_common.scss) · [GacUI animation endpoint](../../suggestions/GacUI/FiniteAnimationEndpoint.md).

| Templates | Animated properties |
| --- | --- |
| Pushbuttons and combo boxes | Outline, face, text and arrow colors on hover, press, opening and enablement. |
| Check boxes and radio buttons | Indicator fill, outline, mark and label on selection, hover, press and enablement. |
| Editor borders shared by text fields, documents, lists and trees | Border and background on focus, hover and enablement. |
| Horizontal and vertical scale handles and scrollbar thumbs | State colors during hover, drag and release. The thumb follows the pointer immediately. |
| Toolbar and ribbon command buttons, ribbon split arrows and gallery arrows | State colors on hover, press, selection and enablement. The toolbar split-arrow divider appears as soon as its region becomes active. |
| Group captions | Text color when enablement changes. |

Notebook selection moves its underline directly to the active page. Row selection, calendar selection, column sorting, tree expansion, menu highlights, caption buttons, focus outlines and keytips update immediately. Scale fill and progress follow their numeric values. Window frames, labels, popups, dividers, ribbon group headers and gallery containers have static surfaces. Showing a popup, switching pages, switching skins and executing a command keep the application's own timing.
