$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v10.15.0/node-v10.15.0-win-x86.7z'
$Checksum32 = 'ba089a8120c63b322c888efd3d959c9b9ce2b3b954a39cd996531c4e4982be43'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v10.15.0/node-v10.15.0-win-x64.7z'
$Checksum64 = 'ac2115dcd5ee53c0c8b10521368aec540370e75cd4f7ff1544a44791c7d3362d'
$ChecksumType64 = 'sha256'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Get-ToolsLocation

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$null = New-Item -ItemType Directory -Force -Path $InstallationPath -ErrorAction Ignore
$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Like "node-v*-win-x*" | Select-Object -First 1).FullName
Start-ChocolateyProcessAsAdmin -ExeToRun 'xcopy' -Statements "`"$UnzipPath`" `"$InstallationPath`" /s /y /q"
Start-ChocolateyProcessAsAdmin -ExeToRun 'cmd' -Statements "/c rmdir `"$UnzipPath`" /s /q"

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
