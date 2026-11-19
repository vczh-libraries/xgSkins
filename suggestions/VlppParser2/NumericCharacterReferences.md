# Numeric character references render as literal text

## Repro

In a Windows 11 caption template, set the Segoe MDL2 Assets close label to `Text="&#xE8BB;"`. Regenerate the skin, rebuild FullControlTest and select Win11Skin in Direct2D hosted mode. The close button displays a run of missing-glyph boxes. The generated `SetText` call receives the literal character-reference spelling.

## Workaround

Save the XML as UTF-8 and place the Unicode character itself in the attribute. Win11Skin uses this representation for the four caption glyphs, checkbox tick and two tree chevrons.

## Root Cause

`XmlUnescapeValue` decodes the five predefined XML entity names. Its fallback copies the next character individually, leaving a numeric reference intact. The resource compiler therefore passes the reference spelling to the generated C++ string. [VlppParser2 XML reader](https://github.com/vczh-libraries/VlppParser2/blob/master/Source/Xml/GlrXml.cpp)

## Proposal

Decode valid decimal and hexadecimal numeric character references into Unicode scalar values when reading text nodes and attribute values. Test both forms, supplementary characters and malformed references in the XML reader.
