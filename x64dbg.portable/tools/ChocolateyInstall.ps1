$ErrorActionPreference = 'Stop'

$PackageName = 'x64dbg'
$Url32 = 'https://sourceforge.net/projects/x64dbg/files/snapshots/snapshot_2021-02-09_17-28.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

. $(Join-Path $ToolsPath "StopProcess.ps1")

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
