$ErrorActionPreference = 'Stop'

$PackageName = 'cmder'
$Url = 'https://github.com/cmderdev/cmder/releases/download/v1.3.3/cmder_mini.zip'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
Install-ChocolateyPath $ToolsPath 'Machine'
