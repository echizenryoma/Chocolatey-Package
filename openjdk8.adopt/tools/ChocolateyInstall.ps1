$ErrorActionPreference = 'Stop'

$PackageName = 'openjdk8'
$Url64 = 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u232-b09_openj9-0.17.0/OpenJDK8U-jdk_x64_windows_openj9_8u232b09_openj9-0.17.0.zip'
$Checksum64 = 'b83053501fcbe69595c2d0919e567c8728b793d7c66ad7bed73f0540894c7397'
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
