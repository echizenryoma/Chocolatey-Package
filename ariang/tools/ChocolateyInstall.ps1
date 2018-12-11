$ErrorActionPreference = 'Stop'

$PackageName = 'ariang'
$Url = 'https://github.com/mayswind/AriaNg/releases/download/1.0.0/AriaNg-1.0.0.zip'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
