$ErrorActionPreference = 'Stop'

$PackageName = 'imagemagick.tool'
$Url32 = 'https://www.imagemagick.org/download/binaries/ImageMagick-7.0.8-0-portable-Q16-x86.zip'
$Url64 = 'https://www.imagemagick.org/download/binaries/ImageMagick-7.0.8-0-portable-Q16-x64.zip'
$Checksum32 = 'a67637380078bc8c4835b2dbcda87ae8887dfff2abe637e375b1882afd27affa'
$Checksum64 = '2af5adf2538d05ce130fe32931dd8cabad752546851bbc51ed1fba26443c3d87'
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
