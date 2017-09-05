$ErrorActionPreference = 'Stop'

$PackageName = 'newfiletime'
$Url32 = 'http://www.softwareok.com/Download/NewFileTime.zip'
$Checksum32 = 'daac48082f29d5a3ff98905f626a2d855581d954f8ee93516a94d7605ca31908'
$ChecksumType32 = 'sha256'
$Url64 = 'http://www.softwareok.com/Download/NewFileTime_x64.zip'
$Checksum64 = 'd224a66c3a7376cdd8f3e783314502964688546dcddf2759ea446b7b59e44db6'
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
