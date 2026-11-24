# Run against a local FullControlTest /D2D /Hosted with Window Manager open and
# the entire Color Theme list visible. Keep the window width fixed during the
# check. The last tested palette stays selected. Pass -Skin to test a subset.
[CmdletBinding()]
param(
    [string[]]$Skin = @('WinXPSkin', 'WinVistaSkin', 'Win7Skin', 'Win8Skin', 'Win10Skin', 'Win10Skin/Dark', 'Win11Skin', 'Win11Skin/Dark'),
    [int]$AppProcessId
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing, UIAutomationClient, UIAutomationTypes, WindowsBase
$baseUrl = 'http://localhost:8888/Automation/FullControlTest'
$options = @('Customized Frame', 'MaximizedBox', 'MinimizedBox', 'Border', 'SizeBox', 'IconVisible', 'TitleBar')
$radioNames = $null

function Get-Rectangle($bounds) {
    [Drawing.Rectangle]::FromLTRB($bounds.x1, $bounds.y1, $bounds.x2, $bounds.y2)
}

function Read-WindowManager {
    $state = Invoke-RestMethod "$baseUrl/Controls" -TimeoutSec 15
    if ($state.WindowManagement -ne 'Hosted' -or $state.MainWindow.title -ne 'Complete Control Showcase') {
        throw 'Expected a hosted FullControlTest window.'
    }
    $windowBounds = Get-Rectangle $state.MainWindow.bounds
    $page = @{ WindowWidth = $windowBounds.Width; Tab = $null; Bounds = [ordered]@{}; Targets = @{} }
    function Visit-Composition($node, $clip, $owner) {
        $bounds = Get-Rectangle $node.bounds
        $visible = [Drawing.Rectangle]::Intersect($clip, $bounds)
        if ($visible.Width -le 0 -or $visible.Height -le 0) { return }
        if ($node.control) {
            $owner = $node
            if ($node.control -eq 'Tab' -and !$page.Tab) { $page.Tab = $bounds }
        }
        $name = $node.elementText
        if (($owner.control -eq 'CheckBox' -and $name -in $options) -or
            ($owner.control -eq 'RadioButton' -and $name -and (!$radioNames -or $name -in $radioNames)) -or
            ($owner.control -eq 'Button' -and $name -eq 'Open New Window')) {
            $page.Targets[$name] = $visible
            foreach ($part in 'control', 'label') {
                $r = if ($part -eq 'control') { Get-Rectangle $owner.bounds } else { $bounds }
                $x = $r.X - $page.Tab.X
                $span = "width=$($r.Width)"
                if ($owner.control -eq 'RadioButton') {
                    # The radios fill the right half of the page. Compare both anchors as the client width changes.
                    $x -= [Math]::Floor($page.Tab.Width / 2)
                    if ($part -eq 'control') { $span = "rightInset=$($page.Tab.Right - $r.Right)" }
                }
                $page.Bounds["$name $part"] = "x=$x y=$($r.Y - $page.Tab.Y) $span height=$($r.Height)"
            }
        }
        foreach ($child in $node.children) { Visit-Composition $child $visible $owner }
    }
    Visit-Composition $state.MainWindow.composition $windowBounds $null
    return $page
}

if (!$AppProcessId) {
    $apps = @(Get-Process -Name FullControlTest -ErrorAction SilentlyContinue)
    if ($apps.Count -ne 1) { throw 'Specify the hosted showcase process with -AppProcessId.' }
    $AppProcessId = $apps[0].Id
}
$byProcess = [Windows.Automation.PropertyCondition]::new([Windows.Automation.AutomationElement]::ProcessIdProperty, $AppProcessId)
$radioType = [Windows.Automation.PropertyCondition]::new(
    [Windows.Automation.AutomationElement]::ControlTypeProperty, [Windows.Automation.ControlType]::RadioButton)

function Measure-Palette($name, $requiredNames) {
    $page = Read-WindowManager
    $target = $page.Targets[$name]
    if (!$target) { throw "Open Window Manager and make the '$name' radio button visible." }
    $x = $target.X + [int][Math]::Floor($target.Width / 2)
    $y = $target.Y + [int][Math]::Floor($target.Height / 2)
    $web = [Net.WebClient]::new()
    try {
        $web.Headers['Content-Type'] = 'application/json; charset=utf8'
        $reply = $web.UploadString("$baseUrl/IO", "!LeftClick:$x,$y")
        if ($reply.Trim() -ne 'Queued') { throw "Palette click returned '$reply'." }
    }
    finally { $web.Dispose() }

    $byName = [Windows.Automation.PropertyCondition]::new([Windows.Automation.AutomationElement]::NameProperty, $name)
    $condition = [Windows.Automation.AndCondition]::new($radioType, $byName)
    $previous = $null
    $timer = [Diagnostics.Stopwatch]::StartNew()
    do {
        Start-Sleep -Milliseconds 150
        try {
            $window = [Windows.Automation.AutomationElement]::RootElement.FindFirst([Windows.Automation.TreeScope]::Children, $byProcess)
            $radio = if ($window) { $window.FindFirst([Windows.Automation.TreeScope]::Descendants, $condition) }
            $selected = $radio -and $radio.GetCurrentPattern([Windows.Automation.SelectionItemPattern]::Pattern).Current.IsSelected
        }
        catch [Windows.Automation.ElementNotAvailableException] {
            $selected = $false
        }
        if ($selected) {
            $page = Read-WindowManager
            if (!($requiredNames | Where-Object { !$page.Targets.ContainsKey($_) })) {
                $signature = "$($page.Tab.Width) " + (ConvertTo-Json -Compress $page.Bounds)
                if ($signature -eq $previous) { return $page }
                $previous = $signature
                continue
            }
        }
        $previous = $null
    } while ($timer.Elapsed.TotalSeconds -lt 15)
    throw "Timed out waiting for '$name' to be selected and all Window Manager controls to settle."
}

$fixedNames = $options + 'Open New Window'
$baseline = Measure-Palette 'DarkSkin' ($fixedNames + 'DarkSkin' + $Skin)
$radioNames = @($baseline.Targets.Keys | Where-Object { $_ -notin $fixedNames })
foreach ($name in $Skin) {
    $sample = Measure-Palette $name ($fixedNames + $radioNames)
    if ($sample.WindowWidth -ne $baseline.WindowWidth) {
        throw "$name window width $($sample.WindowWidth) differs from DarkSkin window width $($baseline.WindowWidth)."
    }
    foreach ($key in $baseline.Bounds.Keys) {
        if ($sample.Bounds[$key] -ne $baseline.Bounds[$key]) {
            throw "$name '$key' measured $($sample.Bounds[$key]), expected $($baseline.Bounds[$key]) in its Window Manager column."
        }
    }
    Write-Output "$name matched all $($baseline.Bounds.Count) Window Manager control and label rectangles."
}
