$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$Url = 'https://notepad-plus-plus.org/repository/7.x/7.4.2/npp.7.4.2.bin.7z'
$Checksum = '8c74caee7ce09b85604701e36effeb62a9daa69d'
$ChecksumType = 'sha1'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$UrlExtra = 'https://notepad-plus-plus.org/repository/7.x/7.4.2/npp.7.4.2.Installer.exe'
$FileName = [IO.Path]::GetFileName($UrlExtra)
$InstallerPath = Join-Path $ToolsPath $FileName
$PackageArgs = @{
    Url      = $UrlExtra
    FileName = $InstallerPath
}
Get-WebFile @PackageArgs
$content = 7z.exe l "$InstallerPath" "NppShell_*.dll"
$NppShellFileName = $content -split "\n| " -match "NppShell" | Select-Object -First 1
if (!(Test-Path $(Join-Path $InstallationPath $NppShellFileName))) {
    7z.exe e "$installer" -y -aos "$NppShellFileName" -o"$InstallationPath"
}
regsvr32.exe /s "$(Join-Path $InstallationPath $NppShellFileName)"
Remove-Item -Path $InstallerPath -Force
