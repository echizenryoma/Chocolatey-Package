$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/56.1.0/mkvtoolnix-32-bit-56.1.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/56.1.0/mkvtoolnix-64-bit-56.1.0.7z'
$Checksum32 = '38fbe92d717a230f35250fd4f1a7086122b7035b'
$ChecksumType32 = 'sha1'
$Checksum64 = 'ae10df0d64c9c9253152cd43e836092d1ec3df00'
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
