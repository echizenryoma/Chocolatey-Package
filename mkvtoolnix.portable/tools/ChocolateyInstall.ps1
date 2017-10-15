$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix.portable'
$Url32 = 'https://mkvtoolnix.download/windows/releases/17.0.0/mkvtoolnix-32-bit-17.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/17.0.0/mkvtoolnix-64-bit-17.0.0.7z'
$Checksum32 = 'd7d7bb4e4fae82c22ed23399e51ce2dd2e04912b'
$ChecksumType32 = 'sha1'
$Checksum64 = '560f68b91a39723409f1d5bcd74fbee774e296ee'
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
