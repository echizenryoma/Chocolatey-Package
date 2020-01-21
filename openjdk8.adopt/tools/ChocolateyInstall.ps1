$ErrorActionPreference = 'Stop'

$PackageName = 'openjdk8'
$Url64 = 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jdk_x64_windows_hotspot_8u242b08.zip'
$Checksum64 = '8288e4d0983019706db89c153d18bfce28d033f646be65c8ae1c33c6c65b943e'
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
