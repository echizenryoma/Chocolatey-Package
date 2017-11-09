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
Get-ChildItem $ToolsPath -File -Filter "*.exe" -Exclude "*citra*.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type File -Force | Out-Null }
