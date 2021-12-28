$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/64.0.0/mkvtoolnix-32-bit-64.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/64.0.0/mkvtoolnix-32-bit-64.0.0.7z'
$Checksum32 = '29410765fce6930598fecf2ead79c6aba6fe087e'
$ChecksumType32 = 'sha1'
$Checksum64 = '29410765fce6930598fecf2ead79c6aba6fe087e'
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
