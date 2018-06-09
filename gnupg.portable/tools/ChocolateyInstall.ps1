$ErrorActionPreference = 'Stop'

$PackageName = 'gpg'
$Url32 = 'https://www.gnupg.org/ftp/gcrypt/binary/gnupg-w32-2.2.8_20180608.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Recurse -Force -ErrorAction Ignore

$BinPath = Join-Path $InstallationPath "bin"
Install-ChocolateyPath -PathToInstall $BinPath -PathType 'Machine'
