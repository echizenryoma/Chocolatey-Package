$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$Url32 = 'https://notepad-plus-plus.org/repository/7.x/7.6.4/npp.7.6.4.bin.7z'
$Checksum32 = 'a49041df72d09be9260bde9cfcf16e87'
$ChecksumType32 = 'sha1'
$Url64 = 'https://notepad-plus-plus.org/repository/7.x/7.6.4/npp.7.6.4.bin.x64.7z'
$Checksum64 = '70ed089edd98089e5d66246e3ecf2943'
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
