$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/46.0.0/mkvtoolnix-32-bit-46.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/46.0.0/mkvtoolnix-64-bit-46.0.0.7z'
$Checksum32 = '07fb3528d60b9215e03fba0eb10aa2a0cb4572f8'
$ChecksumType32 = 'sha1'
$Checksum64 = 'c4a269817e91c52905104f6040883d4d08179a45'
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
