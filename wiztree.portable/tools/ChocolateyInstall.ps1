$ErrorActionPreference = 'Stop'

$PackageName = 'wiztree'
$Url = 'https://www.diskanalyzer.com/files/wiztree_4_10_portable.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$PackageArgs = @{
   PackageName   = $PackageName
   Url           = $Url
   UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
