$ErrorActionPreference = 'Stop'

$PackageName = 'wix'
$Url32 = 'https://github.com/wixtoolset/wix3/releases/download/wix3112rtm/wix311-binaries.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = $ToolsPath

$PackageArgs = @{
  PackageName   = $PackageName
  Url           = $Url32
  UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
