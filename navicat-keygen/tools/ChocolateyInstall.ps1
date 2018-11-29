$ErrorActionPreference = 'Stop'

$PackageName = 'navicat-keygen'
$Url32 = 'https://github.com/DoubleLabyrinth/navicat-keygen/releases/download/v2.3/navicat-keygen-for-x86.zip'
$Url64 = 'https://github.com/DoubleLabyrinth/navicat-keygen/releases/download/v2.3/navicat-keygen-for-x64.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
