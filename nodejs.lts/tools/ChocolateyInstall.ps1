$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v10.16.1/node-v10.16.1-win-x86.7z'
$Checksum32 = 'ba46e3bd5be77d5c13ac41efacb211508bef6da6cff894a2d0e99ddee79a244e'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v10.16.1/node-v10.16.1-win-x64.7z'
$Checksum64 = '70b08ba7b488dee2b135b6d5c02ac5ccd6954fd5623da5b3408dec63ce60e6f9'
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
