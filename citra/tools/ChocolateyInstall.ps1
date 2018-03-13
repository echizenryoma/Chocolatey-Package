$ErrorActionPreference = 'Stop'

$PackageName = 'citra'
<<<<<<< HEAD
$Url = 'https://github.com/citra-emu/citra-canary/releases/download/canary-413/citra-windows-mingw-20180313-485ad0a.7z'
=======
$Url = 'https://github.com/citra-emu/citra-canary/releases/download/canary-413/citra-windows-mingw-20180313-485ad0a.7z'
>>>>>>> e940aeda812aeaec38f44b78fc1316dfb46bc0cb
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
