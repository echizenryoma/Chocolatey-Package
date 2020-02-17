$ErrorActionPreference = 'Stop'

$PackageName = 'wix'
$Url32 = 'https://github.com/wixtoolset/wix3/releases/download/wix3112rtm/wix311-binaries.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

if (Test-Path $InstallationPath) {
  New-Item -Path $InstallationPath -Force
}

$PackageArgs = @{
  PackageName   = $PackageName
  Url           = $Url32
  UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
