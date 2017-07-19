$ErrorActionPreference = 'Stop'

$PackageName = 'sqlitestudio.portable'
$Url = 'http://www.angusj.com/resourcehacker/resource_hacker.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName = $PackageName
    Url = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
