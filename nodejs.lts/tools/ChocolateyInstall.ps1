$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v8.9.4/node-v8.9.4-win-x86.7z'
$Checksum32 = '50ad674fb4c89edf35d3fee2136da86631cb7c0504589eb71ce8a3bb176493ed'
$ChecksumType32 = 'SHA256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v8.9.4/node-v8.9.4-win-x64.7z'
$Checksum64 = '15a847a28358f9ae40bae42f49b033b0180bc10661632c63a9c8487ae980a8ba'
$ChecksumType64 = 'SHA256'
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

New-Item -ItemType Directory -Force -Path $InstallationPath -ErrorAction Ignore | Out-Null
$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Like "node-v*-win-x*" | Select-Object -First 1).FullName
Start-ChocolateyProcessAsAdmin -ExeToRun 'xcopy' -Statements "`"$UnzipPath`" `"$InstallationPath`" /s /y /q"
Start-ChocolateyProcessAsAdmin -ExeToRun 'cmd' -Statements "/c rmdir `"$UnzipPath`" /s /q"

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
