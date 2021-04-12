$ErrorActionPreference = 'Stop'

$PackageName = 'terminus'
$Url32 = 'https://github.com/Eugeny/terminus/releases/download/v1.0.136/terminus-1.0.136-portable.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$DataPath = Join-Path $InstallationPath 'data'
$UnzipLocation = Join-Path $InstallationPath 'tmp'

New-Item -ItemType Directory -Path $DataPath -Force -ErrorAction Ignore

$PackageArgs = @{
  PackageName   = $PackageName
  Url           = $Url32
  UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$BinFile = (Get-ChildItem $UnzipLocation -File -Recurse | Where-Object Name -Match "${PackageName}.exe" | Select-Object -First 1).FullName
$UnzipPath = (Get-Item -Path $BinFile).Directory.FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
$BinFile = (Get-ChildItem $InstallationPath -File | Where-Object Name -Match "${PackageName}.exe" | Select-Object -First 1).FullName
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

Write-Output "$PackageName has been installed in $BinFile"

