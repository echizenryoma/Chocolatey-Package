$ErrorActionPreference = 'Stop'

$PackageName = 'citra'
$Url = 'https://github.com/citra-emu/citra-nightly/releases/download/nightly-409/citra-windows-msvc-20171109-7ef905e.7z'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
