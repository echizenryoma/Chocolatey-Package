$ErrorActionPreference = 'Stop'

$PackageName = 'scrcpy'
$Url32 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.10/scrcpy-win32-v1.10.zip'
$Checksum32 = 'f98b400b3764404b33b212e9762dd6f1593ddb766c1480fc2609c94768e4a8e1'
$ChecksumType32 = 'sha256'
$Url64 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.10/scrcpy-win64-v1.10.zip'
$Checksum64 = '95de34575d873c7e95dfcfb5e74d0f6af4f70b2a5bc6fde0f48d1a05480e3a44'
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
