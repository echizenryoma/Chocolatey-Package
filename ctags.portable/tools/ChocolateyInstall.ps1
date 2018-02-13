$ErrorActionPreference = 'Stop'

$PackageName = 'global'
$Url32 = 'http://prdownloads.sourceforge.net/ctags/ctags58.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    UnzipLocation  = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
