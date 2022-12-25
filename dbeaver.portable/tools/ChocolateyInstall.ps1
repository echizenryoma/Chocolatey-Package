$ErrorActionPreference = 'Stop'

$PackageName = 'dbeaver'
$Url64 = 'https://github.com/dbeaver/dbeaver/releases/download/22.3.1/dbeaver-ce-22.3.1-win32.win32.x86_64.zip'
$InstallationPath = Get-ToolsLocation

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$BinFile = Join-Path $InstallationPath "$PackageName.exe"
Install-BinFile -Name $PackageName -Path $BinFile
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "DBeaver Community Edition.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFile -WorkingDirectory $InstallationPath

$BinFile = Join-Path $InstallationPath "$PackageName-cli.exe"
Install-BinFile -Name "$PackageName-cli" -Path $BinFile
