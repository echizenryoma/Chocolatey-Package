$ErrorActionPreference = 'Stop'

$PackageName = 'ScreenToGif'
$Url32 = 'https://github.com/NickeManarin/ScreenToGif/releases/download/2.35.4/ScreenToGif.2.35.4.Portable.x86.zip'
$Url64 = 'https://github.com/NickeManarin/ScreenToGif/releases/download/2.35.4/ScreenToGif.2.35.4.Portable.x64.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

. $(Join-Path $ToolsPath "StopProcess.ps1")

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$SystemStartMenuPath = [System.Environment]::GetFolderPath('CommonDesktopDirectory')
$BinPath = Join-Path $ToolsPath "$PackageName.exe"
$LinkPath = Join-Path $SystemStartMenuPath "$PackageName.lnk"

Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinPath -WorkingDirectory $ToolsPath
