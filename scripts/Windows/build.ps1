[CmdletBinding()]
param(
    [ValidateSet('Debug', 'Release')][string]$Configuration = 'Debug',
    [ValidateSet('x64', 'Win32')][string]$Platform = 'x64'
)

$ErrorActionPreference = 'Stop'
$repoRoot = [System.IO.Path]::GetFullPath("$PSScriptRoot/../..")
$releaseRoot = [System.IO.Path]::GetFullPath("$repoRoot/../Release")

Push-Location "$repoRoot/Test"
try {
    & "$releaseRoot/.github/Scripts/copilotBuild.ps1" -Configuration $Configuration -Platform $Platform
    if ($LASTEXITCODE -ne 0) {
        throw "TestApps build failed with exit code $LASTEXITCODE."
    }
}
finally {
    Pop-Location
}
