$ErrorActionPreference = 'Stop'

$PackageName = 'openjdk8'
$Url64 = 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u275-b01/OpenJDK8U-jdk_x64_windows_hotspot_8u275b01.zip'
$Checksum64 = 'cfce82307ef498a98155a44ca472873174094aa148ce33ca40b029a0d9bf8bee'
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
