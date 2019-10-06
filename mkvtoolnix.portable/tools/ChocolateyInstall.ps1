$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/38.0.0/mkvtoolnix-32-bit-38.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/38.0.0/mkvtoolnix-64-bit-38.0.0.7z'
$Checksum32 = '43eff4c4ba901a2744a6c516cdce6870f452338a'
$ChecksumType32 = 'sha1'
$Checksum64 = '52167b9eff7952673e7dffe2ce6fbe540e27ac2b'
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
