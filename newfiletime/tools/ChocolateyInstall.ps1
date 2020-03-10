$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'https://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = '950d15b60f46c1e3479ea62cad40a45a406a52950e3c8473d9baacc74bfce64d'
$ChecksumType32 = 'sha256'
$Url64 = 'https://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = '7686a70f5980bc3f7e4c8728279cfe7c8e17014e211711e35e98bdec084fec75'
$ChecksumType64 = 'sha256'
$UrlExtra = 'https://www.softwareok.com/Download/NewFileTime_Unicode.zip'
$ChecksumExtra = 'b94d336e6769e0f3deab0add68f074edcea2880c9480a6a5c09e2d64b5adc779'
$ChecksumTypeExtra = 'sha256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName    = $PackageName
    Url32          = $Url32
    Checksum32     = $Checksum32
    ChecksumType32 = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $UrlExtra
    Checksum       = $ChecksumExtra
    ChecksumType   = $ChecksumTypeExtra
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
