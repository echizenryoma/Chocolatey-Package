$ErrorActionPreference = 'Stop'

$PackageName = 'electerm'
$Url64 = 'https://github.com/electerm/electerm/releases/download/v1.12.7/electerm-1.12.7-win-x64.tar.gz'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

. $(Join-Path $ToolsPath "StopProcess.ps1")

New-Item -ItemType Directory -Path $UnzipLocation -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$TarFile = (Get-ChildItem $UnzipLocation -File -Recurse | Where-Object Name -Match "tar" | Select-Object -First 1).FullName
Write-Output "$PackageName has been untar in $TarFile"
$PackageArgs = @{
    PackageName  = $PackageName
    FileFullPath = $TarFile
    Destination  = $UnzipLocation
}
Get-ChocolateyUnzip @PackageArgs

$BinFile = (Get-ChildItem $UnzipLocation -File -Recurse | Where-Object Name -Match "${PackageName}.exe" | Select-Object -First 1).FullName
$UnzipPath = (Get-Item -Path $BinFile).Directory.FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
$BinFile = (Get-ChildItem $InstallationPath -File | Where-Object Name -Match "${PackageName}.exe" | Select-Object -First 1).FullName
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

Write-Output "$PackageName has been installed in $BinFile"
