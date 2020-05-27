$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v12.17.0/node-v12.17.0-win-x86.7z'
$Checksum32 = 'd79026437e764fa090b562ca504dd6596601105b14fc564d54da4e23a1f52c06'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v12.17.0/node-v12.17.0-win-x64.7z'
$Checksum64 = '1749c9dcfceb29ad0c6ffa447f86d96efec8f97823b3b5e17940de9043113ca3'
$ChecksumType64 = 'sha256'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

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

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "node" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
