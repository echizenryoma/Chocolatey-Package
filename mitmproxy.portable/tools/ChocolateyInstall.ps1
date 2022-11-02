$ErrorActionPreference = 'Stop'

$PackageName = 'mitmproxy'
$Url = 'https://snapshots.mitmproxy.org/9.0.1/mitmproxy-9.0.1-windows.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

. $(Join-Path $ToolsPath "StopProcess.ps1")

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
