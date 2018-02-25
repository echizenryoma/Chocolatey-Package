$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/21.0.0/mkvtoolnix-32-bit-21.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/21.0.0/mkvtoolnix-64-bit-21.0.0.7z'
$Checksum32 = '116430e789ed1d9d8a2e62d5f9aaa76bae24c47b'
$ChecksumType32 = 'SHA1'
$Checksum64 = '46283c33124c8f7dbea3b8fc6bcd551d2f74f77c'
$ChecksumType64 = 'SHA1'
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
