﻿$ErrorActionPreference = 'Stop'

$PackageName = 'ScreenToGif'
$Url = 'https://github.com/NickeManarin/ScreenToGif/releases/download/2.33/ScreenToGif.2.33.Portable.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

. $(Join-Path $ToolsPath "StopProcess.ps1")

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$SystemStartMenuPath = [System.Environment]::GetFolderPath('CommonDesktopDirectory')
$BinPath = Join-Path $ToolsPath "$PackageName.exe"
$LinkPath = Join-Path $SystemStartMenuPath "$PackageName.lnk"

Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinPath -WorkingDirectory $ToolsPath
