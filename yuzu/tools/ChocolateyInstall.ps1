$ErrorActionPreference = 'Stop'

$PackageName = 'yuzu'
$Url64 = 'https://github.com/yuzu-emu/yuzu-canary/releases/download/canary-2790/yuzu-windows-mingw-20191113-0125ea9.7z'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
