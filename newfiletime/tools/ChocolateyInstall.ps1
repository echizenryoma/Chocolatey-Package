$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'http://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = 'ba15f67389ec1743fcb248b93d6def4280ffecf203b2b3b5d7cf532d904128e7'
$ChecksumType32 = 'sha256'
$Url64 = 'http://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = 'bf0ad53b4434fc266016e9ccc19bb7cf3c3c22a19b21b597826ce4dcaedc2674'
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
