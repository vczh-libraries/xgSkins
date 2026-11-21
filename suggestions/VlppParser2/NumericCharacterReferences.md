# XML numeric character references reach generated text literally

## Repro

In a FullControlTest skin resource, set a visible label to `Text="&#65; &#x41;"`, regenerate the resource and rebuild. XML defines both references as the letter `A`. VlppParser2 passes their original spellings to the generated `SetText` call.

## Workaround

For ordinary text, save the XML as UTF-8 and write the character directly. For skin graphics, use the standard `<Polygon/>` element so the generated C++ can draw the same shape across platforms. [Skin authoring guidance](../../Jobs/job.createSkin.prompt.md#special-glyphs)

## Root Cause

`XmlUnescapeValue` recognizes the five predefined XML entity names. Its fallback copies one character at a time, preserving decimal and hexadecimal references in both attribute values and element text. [VlppParser2/Source/Xml/GlrXml.cpp](https://github.com/vczh-libraries/VlppParser2/blob/master/Source/Xml/GlrXml.cpp)

## Skin migration

The 18 former icon-font labels now use polygons. Win8Skin replaced its Webdings checkbox tick. Win10Skin replaced its checkbox tick, four caption icons, combo-box arrow, tree expander and four scrollbar arrows. Win11Skin replaced its checkbox tick, four caption icons and tree expander. Both tree expanders have separate expanded and collapsed shapes. Shared templates also supply the checkable text lists, Win10 date controls and Win10 ribbon gallery. The migration resolves the skin portability issue independently of XML numeric-reference support.
