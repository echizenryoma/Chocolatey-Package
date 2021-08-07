$ErrorActionPreference = 'Stop'

$PackageName = 'cemu'
$Url64 = 'https://cemu.info/releases/cemu_1.25.1.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs
$UnzipPath = Join-Path $UnzipLocation $([IO.Path]::GetFileNameWithoutExtension($Url64))
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore
