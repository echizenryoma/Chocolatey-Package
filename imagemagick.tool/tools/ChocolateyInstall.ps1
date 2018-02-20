$ErrorActionPreference = 'Stop'

$PackageName = 'imagemagick.tool'
$Url32 = 'https://www.imagemagick.org/download/binaries/ImageMagick-7.0.7-23-portable-Q16-x86.zip'
$Url64 = 'https://www.imagemagick.org/download/binaries/ImageMagick-7.0.7-23-portable-Q16-x64.zip'
$Checksum32 = '7a3e93fd92bd1ff60b58bce85fcf97f6591d5af4db78c274aa40b2c86377da07'
$Checksum64 = 'cda6180959aa9000a7cf87a9a9b8c9f018bcbe5935f8141d36b2ce99602af64c'
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
