[CmdletBinding()]
param([Parameter(Mandatory)][string]$ResourceFolder)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$imageFolder = Join-Path $ResourceFolder 'ToolbarImages'
$indexFile = Join-Path $imageFolder 'Images.xml'
$index = [System.IO.File]::ReadAllText($indexFile)
$indexXml = [xml]$index
$artwork = @(
    'TextAlign', 'TextAlignLeft', 'TextAlignCenter', 'TextAlignRight',
    'TextAlignLeftLarge', 'TextAlignCenterLarge', 'TextAlignRightLarge',
    'Bold', 'Italic', 'Underline', 'Strike', 'Delete', 'DeleteLarge', 'RemoveLinkLarge'
)

$entries = foreach ($name in $artwork) {
    $entry = $indexXml.SelectSingleNode("/Folder/Image[@name='$name']")
    if (!$entry) { throw "Missing editor artwork: $name" }
    $source = [System.Drawing.Bitmap]::new((Join-Path $imageFolder $entry.InnerText))
    $variant = [System.Drawing.Bitmap]::new($source.Width, $source.Height)
    $filename = 'LightInk_' + $entry.InnerText
    try {
        for ($y = 0; $y -lt $source.Height; $y++) {
            for ($x = 0; $x -lt $source.Width; $x++) {
                $pixel = $source.GetPixel($x, $y)
                # The default alignment icon includes a colored arrow beside its black strokes.
                $channels = @([int]$pixel.R, [int]$pixel.G, [int]$pixel.B) | Sort-Object
                if ($channels[2] - $channels[0] -le 48) {
                    $ink = 240 - [int](0.83 * $pixel.GetBrightness() * 255)
                    $pixel = [System.Drawing.Color]::FromArgb($pixel.A, $ink, $ink, $ink)
                }
                $variant.SetPixel($x, $y, $pixel)
            }
        }
        $variant.Save((Join-Path $imageFolder $filename), [System.Drawing.Imaging.ImageFormat]::Png)
    } finally {
        $variant.Dispose()
        $source.Dispose()
    }
    $registered = $indexXml.SelectSingleNode("/Folder/Image[@name='LightInk$name']")
    if (!$registered) {
        "  <Image name=`"LightInk$name`" content=`"File`">$filename</Image>"
    } elseif ($registered.InnerText -cne $filename -or $registered.GetAttribute('content') -cne 'File') {
        throw "Unexpected light-ink resource path for $name"
    }
}

$encoding = [System.Text.UTF8Encoding]::new($false)
$newline = if ($index.Contains("`r`n")) { "`r`n" } else { "`n" }
if ($entries) {
    [System.IO.File]::WriteAllText($indexFile, $index.Replace('</Folder>', (($entries -join $newline) + $newline + '</Folder>')), $encoding)
}

foreach ($filename in 'DocumentEditorBase.xml', 'DocumentEditorRibbon.xml') {
    $path = Join-Path $ResourceFolder $filename
    $content = [System.IO.File]::ReadAllText($path)
    if ($filename -eq 'DocumentEditorBase.xml' -and !$content.Contains('prop LightIconInk : bool')) {
        $marker = '          @cpp:Protected'
        $offset = $content.IndexOf($marker)
        if ($offset -lt 0) { throw 'Missing editor member declaration' }
        $members = @(
            '          prop LightIconInk : bool = false {}'
            ''
            '          @cpp:Protected'
            '          func GetEditorIcon(name : string, lightInk : bool) : GuiImageData^'
            '          {'
            '            var path = "ToolbarImages/" & (lightInk ? "LightInk" : "") & name;'
            '            return cast (GuiImageData^) ResolveResource("res", path, true);'
            '          }'
            ''
        ) -join $newline
        $content = $content.Insert($offset, $members + $newline)
    }
    $pattern = '(?<property>LargeImage|Image)-uri="res://ToolbarImages/(?<icon>' + ($artwork -join '|') + ')"'
    $content = [regex]::Replace($content, $pattern, {
        param($match)
        $match.Groups['property'].Value + '-bind="self.GetEditorIcon(&quot;' + $match.Groups['icon'].Value + '&quot;, self.LightIconInk)"'
    })
    [System.IO.File]::WriteAllText($path, $content, $encoding)
}

# The toolbar follows the current alignment command and that command's image.
$path = Join-Path $ResourceFolder 'DocumentEditorToolstrip.xml'
$content = [System.IO.File]::ReadAllText($path)
$before = 'self.document.observe as _(self.SelectAlignmentCommand().Image on _.SelectionChanged)'
$after = '(self.document.observe as _(self.SelectAlignmentCommand() on _.SelectionChanged, _.ModifiedChanged)).Image'
if ($content.Contains($before)) {
    [System.IO.File]::WriteAllText($path, $content.Replace($before, $after), $encoding)
} elseif (!$content.Contains($after)) {
    throw 'Missing alignment dropdown image binding'
}
