$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'https://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = 'd36054bea2113c0671026d5d35a8bad7274191afb2018909e5b2c5add33ba2ca'
$ChecksumType32 = 'SHA256'
$Url64 = 'https://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = 'bcca45d4ebd49102878f90d30e39ec87bc69658f27bf437a4cd58b87495976f8'
$ChecksumType64 = 'SHA256'
$UrlExtra = 'https://www.softwareok.com/Download/NewFileTime_Unicode.zip'
$ChecksumExtra = '394b4bd73879c4e158820e9377a0e7913395ab2badc52787c07cccb03d7402a7'
$ChecksumTypeExtra = 'SHA256'
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

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $UrlExtra
    Checksum       = $ChecksumExtra
    ChecksumType   = $ChecksumTypeExtra
    Url64          = $UrlExtra
    Checksum64     = $ChecksumExtra
    ChecksumType64 = $ChecksumTypeExtra
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
