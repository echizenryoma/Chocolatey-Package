$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/37.0.0/mkvtoolnix-32-bit-37.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/37.0.0/mkvtoolnix-64-bit-37.0.0.7z'
$Checksum32 = '6fdc4405a70a37c37c7ae9152053b5c8acba2940'
$ChecksumType32 = 'sha1'
$Checksum64 = '270659bd9fcc9a85bf801805028dda3087d62c7b'
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
