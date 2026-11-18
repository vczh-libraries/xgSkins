# The EasyLayout table test assumes upstream palette names

The reusable table test requests color presets that the extension showcase does not offer.

## Repro

Run the EasyLayout table palette-retention checks in `FullControlTest /D2D /Hosted`
using the upstream helper’s preset list. Compare the requested names with
**Window Manager / Color Theme**.

The resumed EasyLayout checks completed retention across DarkSkin, Win7Skin
and Win8Skin, followed by table geometry, splitter and rebuild checks. The
table helper then requested `Ember`, an upstream showcase palette absent from
this application's three-entry selector, and stopped at `Missing
ControlType.RadioButton: Ember`. `EasyLayoutPaletteResume.log` retains this
configuration failure.

## Workaround

The historical adapter mapped the loop to the three skin names available in that build
and resumed at the table palette checks. It waited up to 30 seconds for the rebuilt
Layout tab and verified the existing `Updated table` payload before the geometry and
final resize checks. The current showcase also offers WinXPSkin.

## Root Cause

The `EasyLayoutTables` loop embeds upstream presets including `Ember` and `Default`.
Extension showcases supply their own entries.
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs).

## Proposal

Parameterize the palette list so each showcase supplies its actual entries. Check that
the table payload, splitter and geometry assertions still run after each switch.
