$ErrorActionPreference = 'Stop'

$PackageName = 'scrcpy'
$Url32 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.9/scrcpy-win32-v1.9.zip'
$Checksum32 = '3234f7fbcc26b9e399f50b5ca9ed085708954c87fda1b0dd32719d6e7dd861ef'
$ChecksumType32 = 'sha256'
$Url64 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.9/scrcpy-win64-v1.9.zip'
$Checksum64 = '0088eca1811ea7c7ac350d636c8465b266e6c830bb268770ff88fddbb493077e'
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
