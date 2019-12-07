$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/41.0.0/mkvtoolnix-32-bit-41.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/41.0.0/mkvtoolnix-64-bit-41.0.0.7z'
$Checksum32 = 'a3aff9937f73dd1ce86cab4660abacfe065c4364'
$ChecksumType32 = 'sha1'
$Checksum64 = 'c6db324631fefc6dc1756ba844871db1faceeddd'
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
