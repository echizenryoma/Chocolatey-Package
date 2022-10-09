$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/71.1.0/mkvtoolnix-32-bit-71.1.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/71.1.0/mkvtoolnix-64-bit-71.1.0.7z'
$Checksum32 = '1f93b56426edc75acd528fc14a12feca8a4bc683'
$ChecksumType32 = 'sha1'
$Checksum64 = 'b6cd1f5da504bdf66968fc75a743b76c4fd35fe6'
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
