$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/54.0.0/mkvtoolnix-32-bit-54.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/54.0.0/mkvtoolnix-64-bit-54.0.0.7z'
$Checksum32 = '0d18b62d2c6baad1462e878ab4c0c81a4d57f0df'
$ChecksumType32 = 'sha1'
$Checksum64 = '88edb2333200cc2d0604d933555eb44770c3eff3'
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
