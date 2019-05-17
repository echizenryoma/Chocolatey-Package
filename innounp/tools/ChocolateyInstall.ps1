$ErrorActionPreference = 'Stop'

$PackageName = 'innounp'
$Url = 'https://sourceforge.net/projects/innounp/files/innounp/innounp%200.49/innounp049.rar'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
