$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/58.0.0/mkvtoolnix-32-bit-58.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/58.0.0/mkvtoolnix-64-bit-58.0.0.7z'
$Checksum32 = 'd3e372336569abb1c576fee6ca3a10954d81e6f7'
$ChecksumType32 = 'sha1'
$Checksum64 = '6ccc58f4229857ca10a7af10b063ec728ef7cc65'
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
