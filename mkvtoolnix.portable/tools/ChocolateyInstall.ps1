$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/67.0.0/mkvtoolnix-32-bit-67.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/67.0.0/mkvtoolnix-64-bit-67.0.0.7z'
$Checksum32 = '821998995c27ededf71540c39384a1c26c4c06fa'
$ChecksumType32 = 'sha1'
$Checksum64 = '18a2bff37c04b2a3b3384ccd22b611f55b92f1d2'
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
