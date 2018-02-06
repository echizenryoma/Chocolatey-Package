$ErrorActionPreference = 'Stop'

$PackageName = 'wifiinfoview'
$Url = 'http://www.nirsoft.net/utils/wifiinfoview.zip'
$UrlExtra = 'http://www.nirsoft.net/utils/trans/wifiinfoview_schinese1.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$packageArgs = @{
    PackageName   = $PackageName
    Url           = $UrlExtra
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @packageArgs
