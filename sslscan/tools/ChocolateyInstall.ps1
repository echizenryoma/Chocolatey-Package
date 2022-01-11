$ErrorActionPreference = 'Stop'

$PackageName = 'dog'
$Url32 = 'https://github.com/rbsec/sslscan/releases/download/2.0.11/sslscan-win-2.0.11.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

