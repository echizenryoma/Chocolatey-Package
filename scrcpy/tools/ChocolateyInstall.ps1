$ErrorActionPreference = 'Stop'

$PackageName = 'scrcpy'
$Url32 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.16/scrcpy-win32-v1.16.zip'
$Checksum32 = 'b606e7a04212e35ae39a14f5943e4804ed83eb99f794ddc569d4179a1d9c0272'
$ChecksumType32 = 'sha256'
$Url64 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.16/scrcpy-win64-v1.16.zip'
$Checksum64 = '3f30dc5db1a2f95c2b40a0f5de91ec1642d9f53799250a8c529bc882bc0918f0'
$ChecksumType64 = 'sha256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
