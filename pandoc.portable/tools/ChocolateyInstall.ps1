$ErrorActionPreference = 'Stop'

$PackageName = 'pandoc'
$Url = 'https://github.com/jgm/pandoc/releases/download/2.1.1/pandoc-2.1.1-windows.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
