$ErrorActionPreference = 'Stop'

$PackageName = '7-zip'
$Url32 = 'http://www.7-zip.org/a/7z1801.exe'
$Url64 = 'http://www.7-zip.org/a/7z1801-x64.exe'
$UrlExtra = 'http://www.7-zip.org/a/7z1801-extra.7z'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$packageArgs = @{
    PackageName   = $PackageName
    Url           = $UrlExtra
    Url64         = $UrlExtra
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @packageArgs
