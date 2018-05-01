$ErrorActionPreference = 'Stop'

$PackageName = 'imagemagick.tool'
$Url32 = 'https://www.imagemagick.org/download/binaries/ImageMagick-7.0.7-29-portable-Q16-x86.zip'
$Url64 = 'https://www.imagemagick.org/download/binaries/ImageMagick-7.0.7-29-portable-Q16-x64.zip'
$Checksum32 = '12525cc5c98ec003fb345b94313d27c8429ac4798a20869ac2eee2360b586075'
$Checksum64 = 'ce1ee1ffd76e46c7087a5eeac8d79e4229a83106eba4fbd281b3ab907a243255'
$ChecksumType32 = 'sha256'
$ChecksumType64 = 'sha256'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

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
Install-ChocolateyZipPackage @packageArgs

New-Item -Path $ToolsPath -Name 'ffmpeg.exe.ignore' -ItemType File -Force
