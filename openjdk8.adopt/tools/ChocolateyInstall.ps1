$ErrorActionPreference = 'Stop'

$PackageName = 'openjdk8'
$Url64 = 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_windows_hotspot_8u292b10.zip'
$Checksum64 = '2405e11f9f3603e506cf7ab01fcb67a3e3a1cf3e7858e14d629a72c9a24c6c42'
$ChecksumType64 = 'sha256'
$InstallationPath = Join-Path $(Get-ToolsLocation) 'java'
$TmpLocation = Join-Path $InstallationPath 'tmp'

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $TmpLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipLocation = Get-ChildItem $TmpLocation -Directory | Select-Object -Last 1
$JdkLocation = Join-Path $InstallationPath $UnzipLocation.BaseName
Copy-Item -Path $UnzipLocation.FullName -Destination $JdkLocation -Recurse -Force
Remove-Item -Path $TmpLocation -Recurse -Force

$JdkMajorLinkPath = Join-Path $InstallationPath "jdk8"
New-Item -ItemType SymbolicLink -Path $JdkMajorLinkPath -Target $JdkLocation -Force
