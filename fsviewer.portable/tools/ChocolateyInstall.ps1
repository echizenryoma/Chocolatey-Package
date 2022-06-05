$ErrorActionPreference = 'Stop'

$PackageName = 'fsviewer'
$Url32 = 'https://www.faststonesoft.net/DN/FSViewer76.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-ChildItem -Directory $ToolsPath | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
