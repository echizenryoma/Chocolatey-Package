﻿$ErrorActionPreference = 'Stop'

$PackageName = 'x64dbg'
$Url32 = 'https://sourceforge.net/projects/x64dbg/files/snapshots/snapshot_2021-04-13_22-19.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

. $(Join-Path $ToolsPath "StopProcess.ps1")

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
