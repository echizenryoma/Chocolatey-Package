$ErrorActionPreference = 'Stop'

$PackageName = 'qemu'
$Url32 = 'https://qemu.weilnetz.de/w32/qemu-w32-setup-20180519.exe'
$Checksum32 = '245524d26499e9c1ba96854aaad0f654d81799d270c63f6781e65d11dfcbf6f4787fe53c899c2a6ba1af8330faa1cc8bf48a06f59b277fe240ad21ec49a523db'
$ChecksumType32 = 'sha512'
$Url64 = 'https://qemu.weilnetz.de/w64/qemu-w64-setup-20180519.exe'
$Checksum64 = '2010c76a4993c1394e4b6146d4e867dabb0732aa2195d67bf282151fdbcfd5f518d2b49e8ed78640e48b8ec933df92314b02aaa604f7e32e80577fb12cac50fa'
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
