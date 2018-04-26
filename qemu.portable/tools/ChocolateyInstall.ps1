$ErrorActionPreference = 'Stop'

$PackageName = 'qemu'
$Url32 = 'https://qemu.weilnetz.de/w32/qemu-w32-setup-20180424.exe'
$Checksum32 = '3eb2ab8aa3c551fbe1aeddd4af383213e87809acf855f837173695d4af42594ed531f03df5e9e86938278e01b3e313794b71e431c025ad940181203f38639e91'
$ChecksumType32 = 'sha512'
$Url64 = 'https://qemu.weilnetz.de/w64/qemu-w64-setup-20180424.exe'
$Checksum64 = 'b3e8c3ab3a0a6ef5336fbf3d7c8ff49121519dde7001da4f3e21e143934f104b010fa575bc3f48e8a4df2b9ea3aa722ecd5349d2cc9a4fd65e9ea93b0cef298f'
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
