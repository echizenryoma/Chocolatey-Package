$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://nodejs.org/dist/v16.17.1/node-v16.17.1-win-x86.7z'
$Checksum32 = '0f8101648d5c9e49e89fee541da9e574f899716c32b7c51a732b1766b9fc4526'
$ChecksumType32 = 'sha256'
$Url64 = 'https://nodejs.org/dist/v16.17.1/node-v16.17.1-win-x64.7z'
$Checksum64 = '9777e8c4b2864c5b54a0e4e9400f14887db68560a09b94b4113b560a64d1e680'
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
