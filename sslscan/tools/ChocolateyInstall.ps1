$ErrorActionPreference = 'Stop'

$PackageName = 'dog'
$Url32 = 'https://github.com/rbsec/sslscan/releases/download/2.0.15/sslscan-2.0.15.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

