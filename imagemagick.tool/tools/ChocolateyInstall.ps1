$ErrorActionPreference = 'Stop'

$PackageName = 'imagemagick.tool'
$Url32 = 'https://www.imagemagick.org/download/binaries/ImageMagick-7.0.8-57-portable-Q16-x86.zip'
$Url64 = 'https://www.imagemagick.org/download/binaries/ImageMagick-7.0.8-57-portable-Q16-x64.zip'
$Checksum32 = '26a84161184cb40a9eb58adee88a5a5f589d3280145937974adcd5985927bd3b'
$Checksum64 = 'e528860afd750fe09921569776937c289ff9ca19054f2c1f1f95e209baa3f052'
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
