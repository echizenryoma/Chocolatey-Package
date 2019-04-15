$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/33.1.0/mkvtoolnix-32-bit-33.1.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/33.1.0/mkvtoolnix-64-bit-33.1.0.7z'
$Checksum32 = '04ec7ef8c19c6ed0f5f9d41992966740e486e928'
$ChecksumType32 = 'sha1'
$Checksum64 = 'cac584d968e713b6d3aaffea5f822fda7383b36f'
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
