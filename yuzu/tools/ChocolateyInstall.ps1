$ErrorActionPreference = 'Stop'

$PackageName = 'yuzu'
$Url64 = 'https://github.com/yuzu-emu/yuzu-canary/releases/download/canary-2950/yuzu-windows-mingw-20200131-3d75f91.7z'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
