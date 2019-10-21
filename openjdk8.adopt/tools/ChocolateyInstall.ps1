$ErrorActionPreference = 'Stop'

$PackageName = 'openjdk8'
$Url64 = 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_x64_windows_hotspot_8u232b09.zip'
$Checksum64 = 'a8ceaf48582217b413da8d4100407f703c92d1560a763dc85bc49fc226c04958'
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
