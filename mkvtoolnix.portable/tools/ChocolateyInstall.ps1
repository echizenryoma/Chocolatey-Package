$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/27.0.0/mkvtoolnix-32-bit-27.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/27.0.0/mkvtoolnix-64-bit-27.0.0.7z'
$Checksum32 = 'b31cc42da5336c2911f1dda9d0215e5d45fe9fb1'
$ChecksumType32 = 'sha1'
$Checksum64 = 'd6cfff6e6fee2db8849c82dfeb37c8b21657ca1e'
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
