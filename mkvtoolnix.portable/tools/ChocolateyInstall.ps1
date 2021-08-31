$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/61.0.0/mkvtoolnix-32-bit-61.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/61.0.0/mkvtoolnix-64-bit-61.0.0.7z'
$Checksum32 = 'd5271a121c54ccf0b30dd0fc388a3abc5985fe35'
$ChecksumType32 = 'sha1'
$Checksum64 = '14e6278f9d57e666c0c2478b0bbd500db871e28e'
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
