$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'http://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = '2cc8a1aef8673cbfe4ed7fe40551330f2619c0e3de949a952a1a16013fba9a86'
$ChecksumType32 = 'sha256'
$Url64 = 'http://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = 'b1c7764dca7ec8db6c854c29b9280b5c41260b4d0dcc5e022ef0aa9b5a311e24'
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
