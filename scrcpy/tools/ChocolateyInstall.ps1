$ErrorActionPreference = 'Stop'

$PackageName = 'scrcpy'
$Url32 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.14/scrcpy-win32-v1.14.zip'
$Checksum32 = '63fb1b48f0e30372fcf610745a4a3213adc8be3bb1f1c66d4666a8575c6fade4'
$ChecksumType32 = 'sha256'
$Url64 = 'https://github.com/Genymobile/scrcpy/releases/download/v1.14/scrcpy-win64-v1.14.zip'
$Checksum64 = '2be9139e46e29cf2f5f695848bb2b75a543b8f38be1133257dc5068252abc25f'
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
