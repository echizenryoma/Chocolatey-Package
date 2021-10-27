$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://nodejs.org/dist/v16.13.0/node-v16.13.0-win-x86.7z'
$Checksum32 = 'd93bceda06924a46c7035d74e99dd58802960f4ce9dc6c3aa8c55118612c4106'
$ChecksumType32 = 'sha256'
$Url64 = 'https://nodejs.org/dist/v16.13.0/node-v16.13.0-win-x64.7z'
$Checksum64 = 'f4402bebb34339d9b6f1814df17eed278ec79ec6f0f7501203b2681b284c644d'
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
