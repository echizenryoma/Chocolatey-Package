﻿$ErrorActionPreference = 'Stop'

$PackageName = 'gmkvextractgui'
$Url32 = 'https://sourceforge.net/projects/gmkvextractgui/files/v2.6.3/gMKVExtractGUI.v2.6.3.7z'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
