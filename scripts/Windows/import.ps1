[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = [System.IO.Path]::GetFullPath("$PSScriptRoot/../..")
$releaseRoot = [System.IO.Path]::GetFullPath("$repoRoot/../Release")

foreach ($folder in @(
    @{ Source = 'Import'; Destination = 'Release' },
    @{ Source = 'Import-Test'; Destination = 'Release-Test' }
)) {
    $source = Join-Path $releaseRoot $folder.Source
    $destination = [System.IO.Path]::GetFullPath("$repoRoot/Import/$($folder.Destination)")
    if (!(Test-Path -LiteralPath $source -PathType Container)) {
        throw "Missing upstream folder: $source"
    }
    if (!$destination.StartsWith("$repoRoot\Import\", [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Import destination is outside the repository Import folder: $destination"
    }

    & robocopy.exe $source $destination /MIR /NFL /NDL /NJH /NJS /NP
    if ($LASTEXITCODE -ge 8) {
        throw "Import failed for $source with exit code $LASTEXITCODE."
    }
}

$global:LASTEXITCODE = 0
