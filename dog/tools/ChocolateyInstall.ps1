$ErrorActionPreference = 'Stop'

$PackageName = 'dog'
$Url64 = 'https://github.com/ogham/dog/releases/download/v0.1.0/dog-v0.1.0-x86_64-pc-windows-msvc.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

