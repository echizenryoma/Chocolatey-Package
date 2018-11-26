$ErrorActionPreference = 'Stop'

$PackageName = 'sqlitebrowser'
$Url = 'https://github.com/sqlectron/sqlectron-gui/releases/download/v1.30.0/Sqlectron-1.30.0-win.7z'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
