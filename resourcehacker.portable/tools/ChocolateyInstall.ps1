$ErrorActionPreference = 'Stop'

$PackageName = 'resourcehacker.portable'
$Url = 'http://www.angusj.com/resourcehacker/resource_hacker.zip'
$Checksum = '0c2ad1d93d3ed12c3d092f36ab5b0ccf3b70d4d3d50856eba76a6de36e16e921'
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
