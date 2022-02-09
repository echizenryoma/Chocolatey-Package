$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://nodejs.org/dist/v16.14.0/node-v16.14.0-win-x86.7z'
$Checksum32 = '509f2b68d13fde1808c933840e2b1e15fc48a137153496f4bac52f875ad7eeac'
$ChecksumType32 = 'sha256'
$Url64 = 'https://nodejs.org/dist/v16.14.0/node-v16.14.0-win-x64.7z'
$Checksum64 = '936a7096244591f044232b6c023b59301d0d2d3819df0310701d3e9d2be0d7ff'
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
