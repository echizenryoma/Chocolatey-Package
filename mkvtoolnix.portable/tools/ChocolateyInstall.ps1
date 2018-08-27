$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/26.0.0/mkvtoolnix-32-bit-26.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/26.0.0/mkvtoolnix-64-bit-26.0.0.7z'
$Checksum32 = 'c23a64a9fa96033d360eea0fcc080b8d4f1dd4ec'
$ChecksumType32 = 'sha1'
$Checksum64 = '11a9cf37e136be0baa71c3e57d90924a45dbb3fd'
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
