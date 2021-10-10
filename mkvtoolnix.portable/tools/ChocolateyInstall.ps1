$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/62.0.0/mkvtoolnix-32-bit-62.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/62.0.0/mkvtoolnix-64-bit-62.0.0.7z'
$Checksum32 = 'd141e6b282f040e9fb400da5d45f7017b87f9356'
$ChecksumType32 = 'sha1'
$Checksum64 = '956258348e2cc39e7643a5ae29f1046b1de8c0d5'
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
