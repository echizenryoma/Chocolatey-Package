$ErrorActionPreference = 'Stop'

$PackageName = 'nodejs'
$Url32 = 'https://nodejs.org/dist/v16.17.0/node-v16.17.0-win-x86.7z'
$Checksum32 = '3b4ac1a62b3bc58d057b13ae237646ebfd609475766668611728aad0c3679af5'
$ChecksumType32 = 'sha256'
$Url64 = 'https://nodejs.org/dist/v16.17.0/node-v16.17.0-win-x64.7z'
$Checksum64 = 'cec3fe26869f28c5e54fda6d97a4ed5a53a68f28cd9b17e78961cb723177235c'
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
