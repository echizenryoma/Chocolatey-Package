$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix.portable'
$Url32 = 'https://mkvtoolnix.download/windows/releases/19.0.0/mkvtoolnix-32-bit-19.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/19.0.0/mkvtoolnix-64-bit-19.0.0.7z'
$Checksum32 = 'f22ccb0e9e99b36bfda8f2b2736be138042ffc95'
$ChecksumType32 = 'SHA1'
$Checksum64 = 'cda8a5329f678fdcf436650fe3f750f007de426d'
$ChecksumType64 = 'SHA1'
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
