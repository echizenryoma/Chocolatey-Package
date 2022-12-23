$ErrorActionPreference = 'Stop'

$PackageName = 'openjdk11'
$Url64 = 'https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9.1%2B1/OpenJDK11U-jdk_x64_windows_hotspot_11.0.9.1_1.zip'
$Checksum64 = 'fea633dc37f007cb6b1e1af1874da63ad3d5e31817e583048287c67010dce5c8'
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

$JdkMajorLinkPath = Join-Path $InstallationPath "jdk11"
New-Item -ItemType SymbolicLink -Path $JdkMajorLinkPath -Target $JdkLocation -Force
