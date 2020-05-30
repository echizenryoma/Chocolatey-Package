$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/47.0.0/mkvtoolnix-32-bit-47.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/47.0.0/mkvtoolnix-64-bit-47.0.0.7z'
$Checksum32 = '978b8f36f90d6fc2e392de77186e20e4820fa03f'
$ChecksumType32 = 'sha1'
$Checksum64 = '039fd585b41ad41fb4fabcf1b5fc81a9d5efccd9'
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
