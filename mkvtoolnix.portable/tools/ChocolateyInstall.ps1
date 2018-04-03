$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/22.0.0/mkvtoolnix-32-bit-22.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/22.0.0/mkvtoolnix-64-bit-22.0.0.7z'
$Checksum32 = '3fc9496e1acc40e707633bd856ddca8bfa2048e3'
$ChecksumType32 = 'sha1'
$Checksum64 = 'd47b42cfee399210c2c596f2ea1a9bffbd62b6e3'
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
