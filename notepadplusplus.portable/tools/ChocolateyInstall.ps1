$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$Url32 = 'https://notepad-plus-plus.org/repository/7.x/7.6.4/npp.7.6.4.bin.7z'
$Checksum32 = '9adecf5504d3c0b00f5b05d1e035b272b6e05b59040a152dc2b71eb23b36c705'
$ChecksumType32 = 'sha256'
$Url64 = 'https://notepad-plus-plus.org/repository/7.x/7.6.4/npp.7.6.4.bin.x64.7z'
$Checksum64 = '20cbedced0931091f790140f22e713f9486a48ef55a4bef3c7cdd074e31c8114'
$ChecksumType64 = 'sha256'
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
