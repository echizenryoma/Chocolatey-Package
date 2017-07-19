$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix.portable'
$Url32 = 'https://mkvtoolnix.download/windows/releases/13.0.0/mkvtoolnix-32bit-13.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/13.0.0/mkvtoolnix-64bit-13.0.0.7z'
$Checksum32 = '2fc70635ed248cf77e43295059eae94edca16678'
$ChecksumType32 = 'sha1'
$Checksum64 = '747cdbb742861bce421a5b6660c8a4d8b71b04d9'
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
