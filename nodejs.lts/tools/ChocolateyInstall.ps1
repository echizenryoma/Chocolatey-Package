$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v12.18.0/node-v12.18.0-win-x86.7z'
$Checksum32 = '9b9495851c49fa0d53619dc96886c044018ad2378f27c08c978695f15dfc16e2'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v12.18.0/node-v12.18.0-win-x64.7z'
$Checksum64 = 'ba0df9132406a6ce08200e208802662b7199d9094a2734fa886053c977ba77f1'
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
