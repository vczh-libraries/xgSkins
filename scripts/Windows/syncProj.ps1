[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = [System.IO.Path]::GetFullPath("$PSScriptRoot/../..")
$releaseRoot = [System.IO.Path]::GetFullPath("$repoRoot/../Release")
$source = Join-Path $releaseRoot 'Tutorial/GacUI_ControlTemplate/BlackSkin'
$destination = Join-Path $repoRoot 'Test/FullControlTest'
$resourceSource = Join-Path $source 'UI/FullControlTest'
$resourceDestination = [System.IO.Path]::GetFullPath("$destination/UI/FullControlTest")

if (!(Test-Path -LiteralPath $resourceSource -PathType Container)) {
    throw "Missing upstream resource folder: $resourceSource"
}
if (!$resourceDestination.StartsWith("$repoRoot\Test\FullControlTest\UI\", [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Resource destination is outside the test project's UI folder: $resourceDestination"
}

& robocopy.exe $resourceSource $resourceDestination /MIR /XD Source *.xml.log /XF Resource.xml /NFL /NDL /NJH /NJS /NP
if ($LASTEXITCODE -ge 8) {
    throw "Resource synchronization failed with exit code $LASTEXITCODE."
}

Get-ChildItem -LiteralPath $source -File | Where-Object {
    ($_.Name -like 'FullControlTestRaw*' -or $_.BaseName -eq 'SharedDocumentEditor') -and
    $_.Extension -in '.h', '.cpp'
} | Copy-Item -Destination $destination -Force

# Keep the upstream UI while placing generated code beside its resource folder.
$resourcePath = Join-Path $resourceDestination 'Resource.xml'
$resource = [System.IO.File]::ReadAllText((Join-Path $resourceSource 'Resource.xml'))
$resource = $resource.Replace('<Text name="SourceFolder">Source</Text>', '<Text name="SourceFolder">../Source</Text>')
$resource = $resource.Replace('<Text name="Resource">..\..\..\UIRes\BlackSkin.bin</Text>', '<Text name="CppResource">FullControlTestResource.cpp</Text>')
$resource = $resource.Replace('<Text name="Name">Demo</Text>', '<Text name="Name">FullControlTest</Text>')
if (!(Test-Path -LiteralPath $resourcePath) -or [System.IO.File]::ReadAllText($resourcePath) -cne $resource) {
    [System.IO.File]::WriteAllText($resourcePath, $resource, [System.Text.UTF8Encoding]::new($false))
}

& "$releaseRoot/Tools/GacBuild.ps1" -FileName "$repoRoot/Test/GacUI.xml"
