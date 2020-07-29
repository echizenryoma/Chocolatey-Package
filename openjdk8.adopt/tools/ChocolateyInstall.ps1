$ErrorActionPreference = 'Stop'

$PackageName = 'openjdk8'
$Url64 = 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u265-b01_openj9-0.21.0/OpenJDK8U-debugimage_x64_windows_openj9_8u265b01_openj9-0.21.0.zip'
$Checksum64 = '45fd43993c9c378e045adaf4af3fbd33976212367f7762ee7f409fd54cfd1d99'
$ChecksumType64 = 'sha256'
$InstallationPath = Get-ToolsLocation

$JdkVersion = $Url64 -split "/" | Select-Object -Last 2 | Select-Object -First 1
$UnzipLocation = Join-Path $(Get-ToolsLocation) $JdkVersion
if (Test-Path $UnzipLocation) {
    Remove-Item -Path $UnzipLocation -Force -Recurse
}

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
