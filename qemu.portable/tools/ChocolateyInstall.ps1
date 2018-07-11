$ErrorActionPreference = 'Stop'

$PackageName = 'qemu'
$Url32 = 'https://qemu.weilnetz.de/w32/qemu-w32-setup-20180711.exe'
$Checksum32 = 'ae4ea0afffdc8ff3f1f2c08c5cdd21cf439afd289ed7de3b3e9c2e52aaec87982f5fa4362cc5e6988ef9f9b53ba6e68979dfd56dbe088eea7feb9d777166bdc7'
$ChecksumType32 = 'sha512'
$Url64 = 'https://qemu.weilnetz.de/w64/qemu-w64-setup-20180711.exe'
$Checksum64 = '2c9734cdf3e06a91d4a7fc511829c2aa81f4b43786e6c5303c42b5a8a8e7b5f736de359ff2ee143ddd1fe446a30be705a3d696043eac9cc31e3c116b5ac34be9'
$ChecksumType64 = 'sha512'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    ChecksumType   = $ChecksumType32
    Checksum       = $Checksum32
    Url64          = $Url64
    ChecksumType64 = $ChecksumType64
    Checksum64     = $Checksum64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Force -Recurse -ErrorAction Ignore

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
