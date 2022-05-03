$ErrorActionPreference = 'Stop'

$PackageName = 'kdenlive'
$Url64 = 'https://download.kde.org/stable/kdenlive/22.04/windows/kdenlive-22.04.0-1_standalone.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$TmpPath = Join-Path $InstallationPath "tmp"

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $TmpPath
}
Install-ChocolateyZipPackage @PackageArgs

$AppPath = (Get-ChildItem -Path $TmpPath -Directory | Where-Object Name -Match "${PackageName}")[0].FullName
Write-Output "Installing $AppPath"
Copy-Item -Path "$AppPath/*" -Destination $InstallationPath -Force -Recurse

Remove-Item -Path $TmpPath -Force -Recurse

$BinFile = Join-Path $InstallationPath "bin/${PackageName}.exe"
Install-BinFile -Path $BinFile -Name "${PackageName}"
