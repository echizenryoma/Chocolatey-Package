$ErrorActionPreference = 'Stop';

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v6.11.3/node-v6.11.3-win-x86.7z'
$Checksum32 = '59e1dd9dbd312cb16a3a2c1a549625c8d5352d1465d91f47889818beeafa625b'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v6.11.3/node-v6.11.3-win-x64.7z'
$Checksum64 = 'a767bca7033cbbde3294080728b564145ac4fbf13f408a9070d9b5acc5c56068'
$ChecksumType64 = 'sha256'
$ToolsPath = $(Get-ToolsLocation)

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $ToolsPath -Directory | Where-Object Name -Like "node-*-win-x*" | Select-Object -First 1).FullName
$NodejsPath = Join-Path $ToolsPath "nodejs"
Move-Item -Path $UnzipPath -Destination $NodejsPath -Force
Install-ChocolateyPath -PathToInstall $NodejsPath -PathType 'Machine'
