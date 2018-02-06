$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'https://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = 'c5c278815af169050c7eabda3d3a691aaf8ab4c36b750d41bda1afa40f5cbda3'
$ChecksumType32 = 'SHA256'
$Url64 = 'https://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = '1813189ad6bc0328f3531e959df8caec56c8a5a08f72ca81897fd313e4fe90c7'
$ChecksumType64 = 'SHA256'
$UrlExtra = 'https://www.softwareok.com/Download/NewFileTime_Unicode.zip'
$ChecksumExtra = '15d340ba4b99f892c767625d3a1f88194c7cbc716f6b7e1a160949ec7c63c8c2'
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
