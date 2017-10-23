$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'http://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = '4fd75a88cd48f142bf9e56bc14dfa20893722ec830ad574da28756fd26527bea'
$ChecksumType32 = 'sha256'
$Url64 = 'http://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = '23df71ca3760adc1fded9d909a840d62b23f95d1c044cb0253024f65f48765f5'
$ChecksumType64 = 'sha256'
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
