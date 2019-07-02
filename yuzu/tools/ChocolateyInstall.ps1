$ErrorActionPreference = 'Stop'

$PackageName = 'yuzu'
$Url64 = 'https://github.com/yuzu-emu/yuzu-canary/releases/download/canary-2426/yuzu-windows-mingw-20190702-4e49cf1.7z'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
