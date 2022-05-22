$ErrorActionPreference = 'Stop'

$PackageName = 'SuperRDP'
$Url = 'https://github.com/anhkgg/SuperRDP/releases/download/2.0.0.38/SuperRDP2_2.0.0.38.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
