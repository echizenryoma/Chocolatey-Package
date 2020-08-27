$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'https://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = '40868acc602826dcd0ccd59ad354961cfe8bbef6e0b8468c70d64fce16b65ef4'
$ChecksumType32 = 'sha256'
$Url64 = 'https://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = '1f58f168adf9220d1be94c0776c6ad9c9ac880caee9cbc16bc0c7237b157549e'
$ChecksumType64 = 'sha256'
$UrlExtra = 'https://www.softwareok.com/Download/NewFileTime_Unicode.zip'
$ChecksumExtra = '7e406afe9a1f45743632d16816a627d20810c4cbe50d72f76fe0b800c5c6c430'
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
