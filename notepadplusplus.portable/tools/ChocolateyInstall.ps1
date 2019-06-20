$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$Url32 = 'https://notepad-plus-plus.org/repository/7.x/7.7.1/npp.7.7.1.bin.7z'
$Checksum32 = 'f0af67993bd5f420ef0d9268f9667d628090491899f6529a7a75f60244700ef1'
$ChecksumType32 = 'sha256'
$Url64 = 'https://notepad-plus-plus.org/repository/7.x/7.7.1/npp.7.7.1.bin.x64.7z'
$Checksum64 = '528ec2bf90fd409b4bf914c198b93db28cecd4fa2a8cdf6180f1b9cded7f8dfa'
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
