$ErrorActionPreference = 'Stop'

$PackageName = 'cmder'
$Url = 'https://github.com/cmderdev/cmder/releases/download/v1.3.4/cmder_mini.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
Install-ChocolateyPath $InstallationPath 'Machine'
