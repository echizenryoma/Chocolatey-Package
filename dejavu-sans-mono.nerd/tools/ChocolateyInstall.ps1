$ErrorActionPreference = 'Stop'

$PackageName = 'dejavu-sans-mono.nerd'
$Url32 = 'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.0/DejaVuSansMono.zip'
$ToolsPath = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

Get-ChildItem -Directory $ToolsPath | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$AddFontScript = Join-Path $ToolsPath 'Add-Font.ps1'
$RemoveFontScript = Join-Path $ToolsPath 'Remove-Font.ps1'

$FontsHandler = (New-Object -ComObject Shell.Application).Namespace(0x14)
$SystemFontsPath = $FontsHandler.Self.Path
$Fonts = Get-ChildItem $ToolsPath -Recurse -Filter "*.ttf"
foreach ($SourcePath in $Fonts) {
    $InstallPath = Join-Path $SystemFontsPath $SourcePath.Name
    if (Test-Path $InstallPath) {
        & $RemoveFontScript -File $SourcePath.Name
    }
    & $AddFontScript -Path $SourcePath.FullName
}
