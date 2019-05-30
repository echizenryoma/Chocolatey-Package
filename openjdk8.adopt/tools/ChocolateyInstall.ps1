$ErrorActionPreference = 'Stop'

$PackageName = 'openjdk8'
$Url = 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b04_openj9-0.14.2/OpenJDK8U-jdk_x86-32_windows_openj9_8u212b04_openj9-0.14.2.zip'
$Checksum = 'e79204650df11ff488e4ffe4741836d8bcfec2b570159bcb17224ea0020837ca'
$ChecksumType = 'sha256'
$Url64 = 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b04_openj9-0.14.2/OpenJDK8U-jdk_x64_windows_openj9_8u212b04_openj9-0.14.2.zip'
$Checksum64 = '2358865ef78e4b50d470f65fc0f10d60c2d83c7534a9934847e3e3461687962a'
$ChecksumType64 = 'sha256'
$InstallationPath = Get-ToolsLocation

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url
    Checksum       = $Checksum
    ChecksumType   = $ChecksumType
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
