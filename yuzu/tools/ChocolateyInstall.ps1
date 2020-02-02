$ErrorActionPreference = 'Stop'

$PackageName = 'yuzu'
$Url64 = 'https://github.com/yuzu-emu/yuzu-canary/releases/download/canary-2954/yuzu-windows-mingw-20200202-bb321d9.7z'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
