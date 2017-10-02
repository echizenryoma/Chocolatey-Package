$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix.portable'
$Url32 = 'https://mkvtoolnix.download/windows/releases/16.0.0/mkvtoolnix-32-bit-16.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/16.0.0/mkvtoolnix-64-bit-16.0.0.7z'
$Checksum32 = '5fbca01615642b23da9fc0c4b7de77da46669a85'
$ChecksumType32 = 'sha1'
$Checksum64 = 'fc309b1fb7c1e898b964f7c1d1d03cb1e4568374'
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
