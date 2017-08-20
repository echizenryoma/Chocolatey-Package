$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix.portable'
$Url32 = 'https://mkvtoolnix.download/windows/releases/15.0.0/mkvtoolnix-32-bit-15.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/15.0.0/mkvtoolnix-64-bit-15.0.0.7z'
$Checksum32 = 'c7b5656dd8a8e869e8d0b7c157262ad4ffb6037a'
$ChecksumType32 = 'sha1'
$Checksum64 = '0316e325e9187e390213e467c7a7232c0c7a2036'
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
