$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/52.0.0/mkvtoolnix-32-bit-52.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/52.0.0/mkvtoolnix-64-bit-52.0.0.7z'
$Checksum32 = '91c5cd8580f28063f430d16e68403de1f5459968'
$ChecksumType32 = 'sha1'
$Checksum64 = '86d8772fcc26b8ce99dc91d16d1ef5f383d6cfea'
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
