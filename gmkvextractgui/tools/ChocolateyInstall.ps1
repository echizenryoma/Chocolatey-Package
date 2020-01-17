$ErrorActionPreference = 'Stop'

$PackageName = 'gmkvextractgui'
$Url32 = 'https://sourceforge.net/projects/gmkvextractgui/files/v2.5.1/gMKVExtractGUI.v2.5.1.7z'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
