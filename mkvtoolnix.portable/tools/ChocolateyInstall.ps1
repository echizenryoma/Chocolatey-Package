$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/35.0.0/mkvtoolnix-32-bit-35.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/35.0.0/mkvtoolnix-64-bit-35.0.0.7z'
$Checksum32 = '6fd255644799a73bbe9c1de5d5b6ac90adad9354'
$ChecksumType32 = 'sha1'
$Checksum64 = '9a2f0455cf213622e62e90c1f353c3485d74a4f3'
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
