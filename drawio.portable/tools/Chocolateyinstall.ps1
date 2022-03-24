$ErrorActionPreference = 'Stop'

$PackageName = 'drawio'
$Url64 = 'https://github.com/jgraph/drawio-desktop/releases/download/v17.2.1/draw.io-17.2.1-windows-no-installer.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

New-Item -ItemType Directory -Path $UnzipLocation -Force -ErrorAction Ignore

$PackageArgs = @{
  PackageName   = $PackageName
  Url64         = $Url64
  UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$App7zPath = (Get-ChildItem $UnzipLocation -File -Recurse | Sort-Object Length -Descending | Select-Object -First 1).FullName
$PackageArgs = @{
  PackageName   = $PackageName
  Url64         = $App7zPath
  UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore
