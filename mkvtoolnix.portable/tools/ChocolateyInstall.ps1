$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/29.0.0/mkvtoolnix-32-bit-29.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/29.0.0/mkvtoolnix-64-bit-29.0.0.7z'
$Checksum32 = '4b121108a179842076c31b8491c5af39e0ca3370'
$ChecksumType32 = 'sha1'
$Checksum64 = 'baed83d19b20f4e21377337915c1962e6b07ddb3'
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
