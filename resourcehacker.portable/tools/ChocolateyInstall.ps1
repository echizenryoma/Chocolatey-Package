$ErrorActionPreference = 'Stop'

$PackageName = 'resourcehacker.portable'
$Url = 'http://www.angusj.com/resourcehacker/resource_hacker.zip'
$Checksum = '7d33dbc5ab0e4a9e1c88471d8afcba024dc62792f643833869f4e459306b01e6'
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
