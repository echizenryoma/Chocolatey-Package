$ErrorActionPreference = 'Stop'

$PackageName = 'wincontig'
$Url = 'https://www.mdtzone.it/Files/WContig.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
