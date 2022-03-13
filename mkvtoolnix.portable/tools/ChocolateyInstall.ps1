$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/66.0.0/mkvtoolnix-32-bit-66.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/66.0.0/mkvtoolnix-64-bit-66.0.0.7z'
$Checksum32 = 'dbc7f5d22f6606d85dcd85a4bc59eab41b0fcbcc'
$ChecksumType32 = 'sha1'
$Checksum64 = 'bf53538e5b640386044636871a78e51f8dc86b89'
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
