# Skin graphics that depend on icon fonts

**18 `<SolidLabel/>` elements across three skins draw graphics with an installed font.** Win8Skin uses Webdings in one place. Win10Skin and Win11Skin use Segoe MDL2 Assets in 11 and 6 places respectively. Applications can use the generated C++ on a platform that lacks either font. The skin authoring rule calls for drawing these graphics with the standard `<Polygon/>` element. [Special Glyphs](../../Jobs/job.createSkin.prompt.md#special-glyphs)

## Affected templates

Each linked cell identifies one label in the authored skin XML. Each tree expander counts once because a single label switches between two characters. UbuntuSkin, Win7Skin, WinVistaSkin and WinXPSkin have no icon-font drawing sites.

| Graphic | Win8Skin · Webdings | Win10Skin · Segoe MDL2 Assets | Win11Skin · Segoe MDL2 Assets |
| --- | --- | --- | --- |
| Checkbox tick | [`a` (U+0061)](../../Source/Win8Skin/UI/Template_Button.xml#L162) | [U+E001](../../Source/Win10Skin/UI/Template_Button.xml#L83) | [U+E73E](../../Source/Win11Skin/UI/Template_Button.xml#L172) |
| Window minimize | — | [U+E921](../../Source/Win10Skin/UI/Template_Window.xml#L110) | [U+E921](../../Source/Win11Skin/UI/Template_Window.xml#L110) |
| Window maximize | — | [U+E922](../../Source/Win10Skin/UI/Template_Window.xml#L123) | [U+E922](../../Source/Win11Skin/UI/Template_Window.xml#L123) |
| Window restore | — | [U+E923](../../Source/Win10Skin/UI/Template_Window.xml#L126) | [U+E923](../../Source/Win11Skin/UI/Template_Window.xml#L126) |
| Window close | — | [U+E8BB](../../Source/Win10Skin/UI/Template_Window.xml#L179) | [U+E8BB](../../Source/Win11Skin/UI/Template_Window.xml#L179) |
| Combo-box drop-down | — | [U+E70D](../../Source/Win10Skin/UI/Template_List.xml#L65) | — |
| Tree expander (expanded ↓ / collapsed →) | — | [U+E70D / U+E76C](../../Source/Win10Skin/UI/Template_List.xml#L149) | [U+E70D / U+E76C](../../Source/Win11Skin/UI/Template_List.xml#L193) |
| Scroll left | — | [U+E76B](../../Source/Win10Skin/UI/Template_Scroll.xml#L41) | — |
| Scroll right | — | [U+E76C](../../Source/Win10Skin/UI/Template_Scroll.xml#L56) | — |
| Scroll up | — | [U+E70E](../../Source/Win10Skin/UI/Template_Scroll.xml#L71) | — |
| Scroll down | — | [U+E70D](../../Source/Win10Skin/UI/Template_Scroll.xml#L86) | — |
| **Total labels** | **1** | **11** | **6** |

The checkbox templates also draw the ticks in checkable text lists. In Win10Skin the combo-box arrow also appears in date controls, and the ribbon gallery reuses the up and down scroll buttons. Replacing the graphics in their defining templates covers these uses. [Win8 text list](../../Source/Win8Skin/UI/Template_List.xml#L27) · [Win10 text list](../../Source/Win10Skin/UI/Template_List.xml#L27) · [Win11 text list](../../Source/Win11Skin/UI/Template_List.xml#L39) · [Win10 date combo box](../../Source/Win10Skin/UI/Index.xml#L47) · [Win10 date picker](../../Source/Win10Skin/UI/Template_Misc.xml#L58) · [Win10 ribbon gallery](../../Source/Win10Skin/UI/Template_Ribbon.xml#L564)

## Repro

In the Win11Skin close-button label, substitute `Text="&#xE8BB;"` for the literal U+E8BB character. Regenerate the skin, rebuild FullControlTest and select Win11Skin in Direct2D hosted mode. The generated `SetText` receives the eight characters `&#xE8BB;`, and the close button displays a row of missing-glyph boxes.

## Root Cause

VlppParser2's `XmlUnescapeValue` decodes the five predefined XML entity names and copies other input one character at a time. Decimal references such as `&#59579;` and hexadecimal references such as `&#xE8BB;` therefore remain literal in attribute values and element text. Both spellings represent U+E8BB in XML. Segoe MDL2 Assets supplies the close-button shape at that private-use code point. [VlppParser2/Source/Xml/GlrXml.cpp](https://github.com/vczh-libraries/VlppParser2/blob/master/Source/Xml/GlrXml.cpp)

## Workaround

The current MDL2 labels store the characters directly in UTF-8 XML. This bypasses numeric-reference decoding but still requires the icon font at runtime. The Win8Skin checkbox has the same font dependency even though its source character is an ordinary ASCII letter.

## Proposal

Replace the 18 labels above with `<Polygon/>` geometry in the skin templates. Preserve each icon's size, alignment, state colors and visibility, including both tree-expander directions. Win7Skin already draws its checkbox tick and caption buttons with polygons, and Win11Skin does the same for scroll arrows. The skin migration requires no change to VlppParser2. [Win7 checkbox](../../Source/Win7Skin/UI/Template_Button.xml#L204) · [Win7 caption buttons](../../Source/Win7Skin/UI/Template_Window.xml#L110) · [Win11 scroll arrows](../../Source/Win11Skin/UI/Template_Scroll.xml#L66)
