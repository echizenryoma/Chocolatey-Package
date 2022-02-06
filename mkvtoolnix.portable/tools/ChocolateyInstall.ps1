$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/65.0.0/mkvtoolnix-32-bit-65.0.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/65.0.0/mkvtoolnix-64-bit-65.0.0.7z'
$Checksum32 = 'b0c66dfddb76fc62dedba3a741bfdf5bdb96a470'
$ChecksumType32 = 'sha1'
$Checksum64 = '5a9ddfe3f4135356bddf0efd726ceafb88492f97'
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
