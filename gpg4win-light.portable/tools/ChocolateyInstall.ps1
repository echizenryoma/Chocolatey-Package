$ErrorActionPreference = 'Stop'

$PackageName = 'gpg'
$Url32 = 'https://files.gpg4win.org/gpg4win-light-2.3.4.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

if (-Not (Test-Path $(Join-Path $Env:APPDATA "GNU\etc\gnupg"))) {
  Copy-Item -Path $(Join-Path $InstallationPath '$APPDATA\*') -Destination $Env:APPDATA -Recurse -Force
}

Remove-Item -Path $(Join-Path $InstallationPath '$APPDATA') -Recurse -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Recurse -Force -ErrorAction Ignore

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
