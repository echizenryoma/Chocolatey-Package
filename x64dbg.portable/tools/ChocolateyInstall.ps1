$ErrorActionPreference = 'Stop'

$PackageName = 'x64dbg'
$Url = 'https://github.com/x64dbg/x64dbg/releases/download/snapshot/snapshot_2018-02-14_22-42.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName   = $packageName
    Url           = $url
    Url64         = $url
    UnzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
