$ErrorActionPreference = 'Stop'

$PackageName = 'imagemagick.tool'
$Url32 = 'https://www.imagemagick.org/download/binaries/ImageMagick-7.0.8-45-portable-Q16-x86.zip'
$Url64 = 'https://www.imagemagick.org/download/binaries/ImageMagick-7.0.8-45-portable-Q16-x64.zip'
$Checksum32 = '2835d76e2f42f8d45a29f40551a50b5d50119d5413c60f72b6da7bf56d71dfa1'
$Checksum64 = '8e89d68f7cb1437845ceaa071166fce2495f6dfe15215d8b854cd22bed750b2e'
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
