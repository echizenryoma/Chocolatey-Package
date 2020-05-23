$ErrorActionPreference = 'Stop'

$PackageName = 'foobar2000'
$Url = 'https://www.foobar2000.org/files/9f77c080fed5cd14b6711bd37ac5ccc3/foobar2000_v1.5.4.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-Item $UnzipLocation).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Recurse -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $InstallationPath '$R0') -Force -ErrorAction Ignore
Move-Item -Path $(Join-Path $InstallationPath 'foobar2000 Shell Associations Updater.exe') -Destination $(Join-Path $InstallationPath 'Shell Associations Updater.exe') -Force -ErrorAction Ignore


