$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/56.0.0/mkvtoolnix-32-bit-56.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/56.0.0/mkvtoolnix-64-bit-56.0.0.7z'
$Checksum32 = '24f6aa604a37f8a936010f71a0791d265cefe144'
$ChecksumType32 = 'sha1'
$Checksum64 = 'd5af8e0e07cb3dd6eaebb88d501ce78d2418f462'
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
