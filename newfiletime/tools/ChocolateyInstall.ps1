$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'http://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = '3dcb1e2765102034bbbb6fddad39af3c50a3c483d62d8ab73f4c6620b5250e11'
$ChecksumType32 = 'sha256'
$Url64 = 'http://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = 'a4dbd4d1d246f5cc13dfe7110b78f5f42fe2608fa077bcca93bf079ab294d200'
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
