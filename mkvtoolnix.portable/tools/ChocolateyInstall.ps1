$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/48.0.0/mkvtoolnix-32-bit-48.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/48.0.0/mkvtoolnix-64-bit-48.0.0.7z'
$Checksum32 = 'bef4a9998a8ea8e85f06501383b3bc6d32aee38a'
$ChecksumType32 = 'sha1'
$Checksum64 = '99f2de061292bcba308f69532fd6b575b7084ffd'
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
