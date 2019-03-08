$ErrorActionPreference = 'Stop'

$PackageName = 'scrcpy'
$Url32 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.8/scrcpy-win32-v1.8.zip'
$Checksum32 = 'c0c29ed1c66deaa73bdadacd09e598aafb3a117929cf7a314cce1cc45e34de53'
$ChecksumType32 = 'sha256'
$Url64 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.8/scrcpy-win64-v1.8.zip'
$Checksum64 = '9cc980d07bd8f036ae4e91d0bc6fc3281d7fa8f9752d4913b643c0fb72a19fb7'
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
