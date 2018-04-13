$ErrorActionPreference = 'Stop'

$PackageName = 'resourcehacker.portable'
$Url = 'http://www.angusj.com/resourcehacker/resource_hacker.zip'
$Checksum = '7eebef98c1d16168724ad89b1fdd9d76ac61ec98196f370c343b009c36cdf18d'
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
