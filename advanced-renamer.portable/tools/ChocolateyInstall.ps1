$ErrorActionPreference = 'Stop'

$PackageName = 'advanced-renamer'
$Url = 'https://www.advancedrenamer.com/down/advanced_renamer_portable.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
