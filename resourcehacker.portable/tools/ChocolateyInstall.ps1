$ErrorActionPreference = 'Stop'

$PackageName = 'resourcehacker.portable'
$Url = 'http://www.angusj.com/resourcehacker/resource_hacker.zip'
$Checksum = 'c5a0e7f4b8f1089418520562c13d45f8e6fcfff65537830fb166f218b095708c'
$ChecksumType = 'sha256'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
