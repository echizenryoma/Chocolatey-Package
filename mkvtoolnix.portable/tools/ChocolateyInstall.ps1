$ErrorActionPreference = 'Stop'

$PackageName = 'mkvtoolnix'
$Url32 = 'https://mkvtoolnix.download/windows/releases/28.2.0/mkvtoolnix-32-bit-28.2.0.7z'
$Url64 = 'https://mkvtoolnix.download/windows/releases/28.2.0/mkvtoolnix-64-bit-28.2.0.7z'
$Checksum32 = '8296c56606de3880d09e60e77df5919fd36497b6'
$ChecksumType32 = 'sha1'
$Checksum64 = '30820ad5907ac55c0ba6e6c7476bb0fc16b6e997'
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
