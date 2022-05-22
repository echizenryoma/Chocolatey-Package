$ErrorActionPreference = 'Stop'

$PackageName = 'SuperRDP'
$Url = 'https://github.com/anhkgg/SuperRDP/releases/download/2.0.0.38/SuperRDP2_2.0.0.38.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
