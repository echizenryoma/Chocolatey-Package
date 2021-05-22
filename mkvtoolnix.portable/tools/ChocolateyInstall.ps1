$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/57.0.0/mkvtoolnix-32-bit-57.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/57.0.0/mkvtoolnix-64-bit-57.0.0.7z'
$Checksum32 = 'd838e8387ad5eaead48a59664c36cf6da2c66ec0'
$ChecksumType32 = 'sha1'
$Checksum64 = 'e2b1bcf74faace451447ca015a9519831690c1ec'
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
