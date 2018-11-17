$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$Url32 = 'https://notepad-plus-plus.org/repository/7.x/7.6/npp.7.6.bin.7z'
$Checksum32 = '927e8f57a353e0a70ed7f4c2def43c4731e461ee'
$ChecksumType32 = 'sha1'
$Url64 = 'https://notepad-plus-plus.org/repository/7.x/7.6/npp.7.6.bin.x64.7z'
$Checksum64 = '48f37603aeabf8b6708ae1186565f8e256ba93f3'
$ChecksumType64 = 'sha1'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

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

$NppShell = (Get-ChildItem -Path $ToolsPath -Filter "NppShell_*.dll" | Select-Object -First 1).FullName
Copy-Item -Path $NppShell -Destination $InstallationPath -Force
$NppShell = (Get-ChildItem -Path $InstallationPath -Filter "NppShell_*.dll" | Select-Object -First 1).FullName
Start-ChocolateyProcessAsAdmin -ExeToRun 'regsvr32' -Statements "/s `"$NppShell`""

$BinFileName = Join-Path $InstallationPath "notepad++.exe"
Install-BinFile -Name 'notepad++' -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Notepad++.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
