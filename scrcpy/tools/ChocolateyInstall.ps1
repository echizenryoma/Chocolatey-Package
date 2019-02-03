$ErrorActionPreference = 'Stop'

$PackageName = 'ghostscript'
$Url32 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.6/scrcpy-win32-v1.6.zip'
$Checksum32 = '4ca0c5924ab2ebf19b70f6598b2e546f65ba469a72ded2d1b213df3380fb46b1'
$ChecksumType32 = 'sha256'
$Url64 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.6/scrcpy-win64-v1.6.zip'
$Checksum64 = 'f66b7eace8dd6537a9a27176fd824704a284d8e82077ccc903344396043f90c9'
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
