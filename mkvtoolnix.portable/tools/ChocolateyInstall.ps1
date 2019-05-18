$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/34.0.0/mkvtoolnix-32-bit-34.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/34.0.0/mkvtoolnix-64-bit-34.0.0.7z'
$Checksum32 = '666c20ee3d7f9bf385d456e90624b7323e6096be'
$ChecksumType32 = 'sha1'
$Checksum64 = '0a036a32d61f473aed682b5a7a4a8c3c3b2af64a'
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
