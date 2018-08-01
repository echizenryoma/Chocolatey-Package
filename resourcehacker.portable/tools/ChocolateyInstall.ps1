$ErrorActionPreference = 'Stop'

$PackageName = 'resourcehacker.portable'
$Url = 'http://www.angusj.com/resourcehacker/resource_hacker.zip'
$Checksum = 'de24309105f589d0c4f6d19c85d0354c0c8ffe9a2f34054ab2028b4a380c664d'
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
