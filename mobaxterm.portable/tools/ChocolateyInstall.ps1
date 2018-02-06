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

$BinFile = (Get-ChildItem -Path $InstallationPath -Filter "*.exe" -File | Select-Object -Last 1).FullName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "MobaXterm.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFile
