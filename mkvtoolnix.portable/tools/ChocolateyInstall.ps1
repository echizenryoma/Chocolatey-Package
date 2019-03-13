$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/32.0.0/mkvtoolnix-32-bit-32.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/32.0.0/mkvtoolnix-64-bit-32.0.0.7z'
$Checksum32 = '14bf881cbd396500816a9851fa548ef62ed266e3'
$ChecksumType32 = 'sha1'
$Checksum64 = 'ce402b878ca8da0175d6da87c40e2cda510c6bd6'
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
