$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/20.0.0/mkvtoolnix-32-bit-20.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/20.0.0/mkvtoolnix-64-bit-20.0.0.7z'
$Checksum32 = 'a8ea79946987a8954f423511c887af3a38876954'
$ChecksumType32 = 'SHA1'
$Checksum64 = '155f5f04d1593bd820943859ba08c22ed82a7ba1'
$ChecksumType64 = 'SHA1'
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
