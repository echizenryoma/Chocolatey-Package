$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/69.0.0/mkvtoolnix-32-bit-69.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/69.0.0/mkvtoolnix-64-bit-69.0.0.7z'
$Checksum32 = 'e30ac2f0146ad89d28d47c672dc729a0574093f9'
$ChecksumType32 = 'sha1'
$Checksum64 = 'b6a2711146d5641d9c23ad00a08dc740250f7c11'
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
