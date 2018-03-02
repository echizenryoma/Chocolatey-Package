$ErrorActionPreference = 'Stop'

$PackageName = 'mobaxterm'
$Url = 'https://download.mobatek.net/10520180106182002/MobaXterm_Portable_v10.5.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$BinPath = (Get-ChildItem -Path $InstallationPath -Filter "*.exe" -File | Select-Object -Last 1).FullName
Install-BinFile -Name Code -Path $BinPath
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Visual Studio Code.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
