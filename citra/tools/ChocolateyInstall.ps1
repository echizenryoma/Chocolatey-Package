$ErrorActionPreference = 'Stop'

$PackageName = 'citra'
$Url = 'https://github.com/citra-emu/citra-nightly/releases/download/nightly-405/citra-windows-msvc-20171108-908dbf4.7z'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
