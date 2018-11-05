$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'https://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = 'ed8294f7df2083f63a44f0940a3d03e27bf41fc7e715cd94c064367d517473e2'
$ChecksumType32 = 'sha256'
$Url64 = 'https://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = ''
$ChecksumType64 = 'sha256'
$UrlExtra = 'https://www.softwareok.com/Download/NewFileTime_Unicode.zip'
$ChecksumExtra = ''
$ChecksumTypeExtra = 'sha256'
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
