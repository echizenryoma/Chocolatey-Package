$ErrorActionPreference = 'Stop'

$PackageName = 'nsis'
$Url = 'https://sourceforge.net/projects/nsis/files/NSIS%203/3.04/nsis-3.04.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Get-ToolsLocation

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$null = New-Item -ItemType Directory -Force -Path $InstallationPath -ErrorAction Ignore
$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -EQ "$([IO.Path]::GetFileNameWithoutExtension($Url))" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore

Install-BinFile -Path $(Join-Path $InstallationPath 'makensis.exe') -Name 'makensis'
