$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$Url = 'https://notepad-plus-plus.org/repository/7.x/7.5.4/npp.7.5.4.bin.7z'
$Checksum = '9633920a02980be62273093c4364bd07b8bb64a2'
$ChecksumType = 'SHA1'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$UrlExtra = 'https://notepad-plus-plus.org/repository/7.x/7.5.4/npp.7.5.4.Installer.exe'
$ChecksumExtra = '9633920a02980be62273093c4364bd07b8bb64a2'
$ChecksumTypeExtra = 'SHA1'
$FileName = [IO.Path]::GetFileName($UrlExtra)
$InstallerPath = Join-Path $InstallationPath $FileName
$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $UrlExtra
    Checksum     = $ChecksumExtra
    ChecksumType = $ChecksumTypeExtra
    FileFullPath = $InstallerPath
}
Get-ChocolateyWebFile @PackageArgs
$NppShellInformation = 7z l "`"$InstallerPath`"" "NppShell_*.dll"
$NppShellFileName = $NppShellInformation -split "\n|\s" -match "NppShell" | Select-Object -First 1
if (!(Test-Path $(Join-Path $InstallationPath $NppShellFileName))) {
    $null = 7z e "`"$InstallerPath`"" -y -aos "`"$NppShellFileName`"" -o"`"$InstallationPath`""
}
$NppShell = Join-Path $InstallationPath $NppShellFileName
Start-ChocolateyProcessAsAdmin -ExeToRun 'regsvr32' -Statements "/s `"$NppShell`""
Remove-Item -Path $InstallerPath -Force -ErrorAction Ignore

$BinFileName = Join-Path $InstallationPath "notepad++.exe"
Install-BinFile -Name 'notepad++' -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Nodepad++.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName