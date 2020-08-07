$ErrorActionPreference = 'Stop'

$PackageName = 'scrcpy'
$Url32 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.15.1/scrcpy-win32-v1.15.1.zip'
$Checksum32 = '80b6930d0a515431b5e814f5e716a5bbf89baade5769e3a90f83ed14812d8e8c'
$ChecksumType32 = 'sha256'
$Url64 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.15.1/scrcpy-win64-v1.15.1.zip'
$Checksum64 = '78fba4caad6328016ea93219254b5df391f24224c519a2c8e3f070695b8b38ff'
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
