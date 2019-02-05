$ErrorActionPreference = 'Stop'

$PackageName = 'cemu'
$Url64 = 'http://cemu.info/releases/cemu_1.15.2.zip'
$UnzipLocation = Get-ToolsLocation
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    UnzipLocation  = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$null = New-Item -ItemType Directory -Force -Path $InstallationPath -ErrorAction Ignore
$UnzipPath = Join-Path $UnzipLocation $([IO.Path]::GetFileNameWithoutExtension($Url64))
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore
