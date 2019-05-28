﻿$ErrorActionPreference = 'Stop'

$PackageName = 'gpg'
$Url32 = 'https://www.gnupg.org/ftp/gcrypt/binary/gnupg-w32-2.2.16_20190528.exe'
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
