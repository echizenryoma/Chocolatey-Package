$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/33.0.0/mkvtoolnix-32-bit-33.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/33.0.0/mkvtoolnix-64-bit-33.0.0.7z'
$Checksum32 = '0f0b091aeda7f7eb72247eec5b47f51c16d7a5aa'
$ChecksumType32 = 'sha1'
$Checksum64 = '3cce17c0988a927d91fce96d4ec288474103d0c4'
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
