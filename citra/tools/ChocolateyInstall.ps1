$ErrorActionPreference = 'Stop'

$PackageName = 'citra'
$Url = 'https://github.com/citra-emu/citra-canary/releases/download/canary-2166/citra-windows-mingw-20220608-b9b66af.7z'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
