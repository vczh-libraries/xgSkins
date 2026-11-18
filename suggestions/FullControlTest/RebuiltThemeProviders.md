# EasyLayout can query a rebuilt tab before its provider is available

Retiring the old palette provider can precede the replacement Window Manager tab becoming reachable.

## Repro

In `FullControlTest /D2D /Hosted`, run the EasyLayout scenario through its docking,
rebuild, splitter and resize checks. Switch themes, then request Window Manager as
soon as the old provider retires.

The EasyLayout-only run completed its initial docking, control rebuild,
splitter and resize checks, then failed `Missing ControlType.TabItem: Window
Manager` immediately after the old DarkSkin palette attachment retired.
`easylayout-refresh-observation.json` subsequently showed the rebuilt DarkSkin
Window Manager. Retirement of the old provider did not establish that its
replacement tree was already available to the next immediate lookup.

## Workaround

The temporary EasyLayout adapter reacquires the root with
`AutomationElement.FromHandle` and waits up to 30 seconds for
`FindNamed(root, "Window Manager", ControlType.TabItem)` before navigating. The
continuation checks the retained checkbox, Second combo choice and editor marker, then
runs the remaining skin and table-layout checks. The initial stop is in
`EasyLayoutOnly.log` and `fresh13912-sweep.log`.

## Root Cause

`EasyLayout` calls `Page` immediately after retirement and root reacquisition.
`PersistencePalette` already waits for a rebuilt tab. These events also precede
settled geometry in some runs.
[<GacUI-repo>/Test/UIA_CppTest_Shared.cs](https://github.com/vczh-libraries/GacUI/blob/master/Test/UIA_CppTest_Shared.cs)
· [Hosted window geometry](../GacUI/ThemeRefreshLayoutReadiness.md).

## Proposal

Apply the bounded replacement-provider wait consistently. Regress consecutive theme
changes with retained control values and current geometry, and retain a timeout for a
permanently missing tab.
