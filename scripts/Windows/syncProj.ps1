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

# The upstream showcase assumes a dark palette in a few raw-element labels.
# Keep ordinary readouts theme-aware, while preserving explicit custom demo styles.
# Keep the tracker fixture large enough for the Win7 and XP templates as well.
$readabilityReplacements = @{
    'DataGridComponents.xml' = @(
        @{ Before = '  <Folder name="GenderComponents">'; After = '  <Instance name="WebsiteLinkVisualizerResource" content="File">../WebsiteLinkVisualizer.xml</Instance>
  <Folder name="GenderComponents">' }
    )
    'DataGridTabPage.xml' = @(
        @{ Before = 'HyperlinkVisualizerTemplate;FocusRectangleVisualizerTemplate;CellBorderVisualizerTemplate'; After = 'demo:WebsiteLinkVisualizer;FocusRectangleVisualizerTemplate;CellBorderVisualizerTemplate' }
    )
    'DatePickerTabPage.xml' = @(
        @{ Before = '<SolidLabel Font-bind="self.DisplayFont" Color="#FFFFFF" Text-format='; After = '<Label Font-bind="self.DisplayFont" Text-format=' }
    )
    'LocalizedStringsTabPage.xml' = @(
        @{ Before = '<SolidLabel Font-bind="self.DisplayFont" Color="#FFFFFF" Text-str="Label()" VerticalAlignment="Center"/>'; After = '<Label Font-bind="self.DisplayFont" Text-str="Label()"/>' }
    )
    'LocalizedDialogsTabPage.xml' = @(
        @{ Before = '<SolidLabel Font-bind="self.DisplayFont" Color="#FFFFFF" Text="Locale only works in FakeDialogService (default in Hosted Mode)" VerticalAlignment="Center"/>'; After = '<Label Font-bind="self.DisplayFont" Text="Locale only works in FakeDialogService (default in Hosted Mode)"/>' }
        @{ Before = '<SolidLabel ref.Name="label" Font-eval="self.DisplayFont" Color="#FFFFFF" Text="Sample Text"/>'; After = '<Label ref.Name="label" Font-eval="self.DisplayFont" Text="Sample Text"/>' }
        @{ Before = 'label.Color'; After = 'label.TextColor' }
        @{ Before = 'dialog.SelectedFont = label.Font;'; After = 'dialog.SelectedFont = label.DisplayFont;' }
    )
    'DocumentEditorRibbon.xml' = @(
        @{ Before = '<CustomControl ref.Name="containerControl">'; After = '<CustomControl ref.Name="containerControl">
          <Label ref.Name="themeLabel" Visible="false"/>' }
        @{ Before = '<SolidLabel ref.Name="styleLabel" Text="AaBbCc" Ellipse="true" Color="#FFFFFF"'; After = '<SolidLabel ref.Name="styleLabel" Text="AaBbCc" Ellipse="true" Color-eval="themeLabel.TextColor"' }
        @{ Before = 'cast Color (self.Selected ? "#FFFFFF" : "#808080")'; After = 'themeLabel.TextColor' }
        @{ Before = '<att.Color-bind>'; After = '<att.Color-eval>' }
        @{ Before = '</att.Color-bind>'; After = '</att.Color-eval>' }
        @{ Before = '<SolidLabel Text-bind="ViewModel.Name" Color="#FFFFFF" Font-eval="containerControl.DisplayFont"/>'; After = '<Label Text-bind="ViewModel.Name" Font-eval="containerControl.DisplayFont"/>' }
        @{ Before = '<SolidLabel Font-bind="self.DisplayFont" Color="#FFFFFF" Text="Search: " HorizontalAlignment="Center" VerticalAlignment="Center"/>'; After = '<Label Font-bind="self.DisplayFont" Text="Search: "/>' }
    )
    'VerticalTabTemplate.xml' = @(
        @{ Before = '          <SolidBackground ref.Style="generalBackground"/>'; After = '' }
        @{ Before = '          <Cell Site="row:0 column:0">'; After = '          <Cell Site="row:0 column:0">
            <SolidBackground ref.Style="generalBackground"/>' }
    )
    'TouchingListTabPage.xml' = @(
        @{ Before = 'self.VisuallyEnabled ? self.TextColor : self.Colors.TextDisabled'; After = 'self.VisuallyEnabled ? self.Colors.TextNormal : self.Colors.TextDisabled' }
    )
    'RepeatTabPage.xml' = @(
        @{ Before = '      <att.Rows>
        <_>composeType:Percentage percentage:1.0</_>
        <_>composeType:Absolute absolute:20</_>
        <_>composeType:Absolute absolute:20</_>
        <_>composeType:Absolute absolute:20</_>
      </att.Rows>'; After = '      <att.Rows>
        <_>composeType:Percentage percentage:1.0</_>
        <_>composeType:Absolute absolute:20</_>
        <_>composeType:Absolute absolute:21</_>
        <_>composeType:Absolute absolute:20</_>
      </att.Rows>' }
        @{ Before = '      <att.Columns>
        <_>composeType:Percentage percentage:1.0</_>
        <_>composeType:Absolute absolute:20</_>
        <_>composeType:Absolute absolute:20</_>
      </att.Columns>'; After = '      <att.Columns>
        <_>composeType:Percentage percentage:1.0</_>
        <_>composeType:Absolute absolute:20</_>
        <_>composeType:Absolute absolute:21</_>
      </att.Columns>' }
    )
}
foreach ($fileName in $readabilityReplacements.Keys) {
    $resourceFile = Join-Path $resourceDestination $fileName
    $content = [System.IO.File]::ReadAllText($resourceFile)
    $newLine = if ($content.Contains("`r`n")) { "`r`n" } else { "`n" }
    foreach ($replacement in $readabilityReplacements[$fileName]) {
        $before = $replacement.Before.Replace("`r`n", "`n").Replace("`n", $newLine)
        $after = $replacement.After.Replace("`r`n", "`n").Replace("`n", $newLine)
        if (!$content.Contains($before)) {
            throw "Upstream showcase changed; review the skin showcase patch for $fileName."
        }
        $content = $content.Replace($before, $after)
    }
    [System.IO.File]::WriteAllText($resourceFile, $content, [System.Text.UTF8Encoding]::new($false))
}

& "$PSScriptRoot/syncEditorArtwork.ps1" -ResourceFolder $resourceDestination

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
