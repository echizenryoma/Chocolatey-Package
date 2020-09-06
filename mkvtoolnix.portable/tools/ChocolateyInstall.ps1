$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/50.0.0/mkvtoolnix-32-bit-50.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/50.0.0/mkvtoolnix-64-bit-50.0.0.7z'
$Checksum32 = '23d0daf73a5ec0c942f10b57890d48f91a13d88a'
$ChecksumType32 = 'sha1'
$Checksum64 = 'e923588c7999ba3a1531c43ad31f364dd18a0f9d'
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
