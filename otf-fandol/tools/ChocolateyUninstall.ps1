$ToolsPath = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$RemoveFontScript = Join-Path $ToolsPath 'Remove-Font.ps1'

$FontsHandler = (New-Object -ComObject Shell.Application).Namespace(0x14)
$SystemFontsPath = $FontsHandler.Self.Path
$Fonts = Get-ChildItem $ToolsPath -Recurse -Filter "*.otf"
foreach ($SourcePath in $Fonts) {
    Write-Host $SourcePath.Name
    $InstallPath = Join-Path $SystemFontsPath $SourcePath.Name
    if (Test-Path $InstallPath) {
        & $RemoveFontScript -File $SourcePath.Name
    }
}

Get-ChildItem -Directory $ToolsPath | Remove-Item -Recurse -Force -ErrorAction Ignore
