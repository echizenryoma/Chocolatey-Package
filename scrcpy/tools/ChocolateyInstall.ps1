$ErrorActionPreference = 'Stop'

$PackageName = 'scrcpy'
$Url32 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.13/scrcpy-win32-v1.13.zip'
$Checksum32 = '0fc5a702cc3aa5bf05108843a9cc443c63cb4754539b72f884defadca3d62da6'
$ChecksumType32 = 'sha256'
$Url64 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.13/scrcpy-win64-v1.13.zip'
$Checksum64 = '806aafc00d4db01513193addaa24f47858893ba5efe75770bfef6ae1ea987d27'
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
