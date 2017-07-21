$ErrorActionPreference = 'Stop';

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v6.11.0/node-v6.11.0-win-x86.7z'
$Checksum32 = '9bed6a3ce1fba503e54ef8f49a109b515f2f872037304edcc4c04eda1fff215b'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v6.11.0/node-v6.11.0-win-x64.7z'
$Checksum64 = '335f5918cbebaf5a819fe575eee0cb1646625a09709416bc293e837b660d1800'
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
