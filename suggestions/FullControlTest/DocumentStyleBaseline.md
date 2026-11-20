# The document-style test assumes a white default foreground

The style-gallery assertion hard-codes DarkSkin’s ordinary foreground when it checks
document styles under other skins.

## Repro

Select Win7Skin in `FullControlTest /D2D /Hosted` and run `DocumentStyles` on
**Control / Document Editor (Ribbon)**. Compare an ordinary run with the baseline of a
plain editor, then inspect an explicitly colored style. Win7Skin’s default foreground
is black. The original helper expects white.

## Workaround

The verification adapter obtains the baseline foreground from a plain editor in the
active theme. It keeps exact color assertions for explicitly colored document styles.

## Root Cause

The upstream helper uses one expected foreground for ordinary text across palettes.
The skin configures that document baseline.
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).

## Proposal

Read the active editor baseline for ordinary text and retain exact checks for explicit
styles. Run the assertions under DarkSkin and a light skin, including a theme change.
