$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/28.1.0/mkvtoolnix-32-bit-28.1.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/28.1.0/mkvtoolnix-64-bit-28.1.0.7z'
$Checksum32 = '848d8240d655b9f7694a5acf767ce2c8f67903db'
$ChecksumType32 = 'sha1'
$Checksum64 = '2ac3aa8fd5349ef38b93a7a34ea8b102fe57bbdd'
$ChecksumType64 = 'sha1'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName    = $PackageName
    url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
