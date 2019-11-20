$ErrorActionPreference = 'Stop'

$PackageName = 'scrcpy'
$Url32 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.11/scrcpy-win32-v1.11.zip'
$Checksum32 = 'f25ed46e6f3e81e0ff9b9b4df7fe1a4bbd13f8396b7391be0a488b64c675b41e'
$ChecksumType32 = 'sha256'
$Url64 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.11/scrcpy-win64-v1.11.zip'
$Checksum64 = '3802c9ea0307d437947ff150ec65e53990b0beaacd0c8d0bed19c7650ce141bd'
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
