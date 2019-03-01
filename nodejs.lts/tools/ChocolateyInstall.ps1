$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://npm.taobao.org/mirrors/node/v10.15.2/node-v10.15.2-win-x86.7z'
$Checksum32 = 'd03762a0649ab87d1fdd5c137a3d9bfe7a770227e78600aa8790b0f66dc534bd'
$ChecksumType32 = 'sha256'
$Url64 = 'https://npm.taobao.org/mirrors/node/v10.15.2/node-v10.15.2-win-x64.7z'
$Checksum64 = '9872ed9b430858087e2ca843c6c5443a1227bb6dca59c044afb80acf800fd432'
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
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
