$ErrorActionPreference = 'Stop'

$PackageName = '7-zip'
$Url32 = 'https://www.7-zip.org/a/7z1805.exe'
$Url64 = 'https://www.7-zip.org/a/7z1805-x64.exe'
$UrlExtra = 'https://www.7-zip.org/a/7z1805-extra.7z'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $UrlExtra
    Url64         = $UrlExtra
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @packageArgs

Install-BinFile -File $(Join-Path $InstallationPath "7z.exe") -Name "7z"
