$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/55.0.0/mkvtoolnix-32-bit-55.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/55.0.0/mkvtoolnix-64-bit-55.0.0.7z'
$Checksum32 = '7a6e8dd9ec61f35a44492afcea5fd44dd44f19d1'
$ChecksumType32 = 'sha1'
$Checksum64 = '971ec91c6e2394b77780fe4d1b082fe130020267'
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
