﻿$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$Url32 = 'http://download.notepad-plus-plus.org/repository/7.x/7.8.7/npp.7.8.7.bin.7z'
$Checksum32 = ''
$ChecksumType32 = 'sha256'
$Url64 = 'http://download.notepad-plus-plus.org/repository/7.x/7.8.7/npp.7.8.7.bin.x64.7z'
$Checksum64 = ''
$ChecksumType64 = 'sha256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$ConfigFile = Join-Path $InstallationPath "config.xml"
$OriginConfigFile = Join-Path $InstallationPath "config.xml.orgin"
if (Test-Path -Path $ConfigFile) {
    Copy-Item -Path $ConfigFile -Destination $OriginConfigFile -Force
}

$PackageArgs = @{
    PackageName    = $PackageName
    Url32          = $Url32
    Checksum32     = $Checksum32
    ChecksumType32 = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

if (Test-Path -Path $OriginConfigFile) {
    Copy-Item -Path $OriginConfigFile -Destination $ConfigFile -Force
}

$NppShell = (Get-ChildItem -Path $ToolsPath -Filter "NppShell_*.dll" | Select-Object -First 1).FullName
Copy-Item -Path $NppShell -Destination $InstallationPath -Force
$NppShell = (Get-ChildItem -Path $InstallationPath -Filter "NppShell_*.dll" | Select-Object -First 1).FullName
Start-ChocolateyProcessAsAdmin -ExeToRun 'regsvr32' -Statements "/s `"$NppShell`""

$BinFileName = Join-Path $InstallationPath "notepad++.exe"
Install-BinFile -Name 'notepad++' -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Notepad++.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
