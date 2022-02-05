$ErrorActionPreference = 'Stop'

$PackageName = 'maxima'
$Url32 = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.45.1-Windows/maxima-5.45.1s-win32.exe/download'
$Url64 = 'https://sourceforge.net/projects/maxima/files/Maxima-Windows/5.45.1-Windows/maxima-5.45.1s-win64.exe/download'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-Item $UnzipLocation).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Recurse -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $InstallationPath 'Uninstall.exe.nsis') -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $InstallationPath '[LICENSE].txt') -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $InstallationPath '[NSIS].nsi') -Force -ErrorAction Ignore
