$ErrorActionPreference = 'Stop'

$PackageName = 'fsview.portable'
$Url32 = 'http://www.faststonesoft.net/DN/FSViewer63.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
