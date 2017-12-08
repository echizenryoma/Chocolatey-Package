$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix.portable'
$Url32 = 'https://mkvtoolnix.download/windows/releases/18.0.0/mkvtoolnix-32-bit-18.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/18.0.0/mkvtoolnix-64-bit-18.0.0.7z'
$Checksum32 = '743f4ef38875809c161ce72abeff84852fce66a5'
$ChecksumType32 = 'sha1'
$Checksum64 = '81b35405753be68ac4e3712e397580a1acd218fd'
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
