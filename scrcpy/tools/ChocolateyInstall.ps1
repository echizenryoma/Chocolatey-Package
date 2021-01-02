$ErrorActionPreference = 'Stop'

$PackageName = 'scrcpy'
$Url32 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.17/scrcpy-win32-v1.17.zip'
$Checksum32 = '9a964721c67cc2af0c89d99c2264b2ccb630f004317cbd1611a9256018456878'
$ChecksumType32 = 'sha256'
$Url64 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.17/scrcpy-win64-v1.17.zip'
$Checksum64 = '8b9e57993c707367ed10ebfe0e1ef563c7a29d9af4a355cd8b6a52a317c73eea'
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
