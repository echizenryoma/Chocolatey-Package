$ErrorActionPreference = 'Stop'

$PackageName = 'cmder'
$Url = 'https://github.com/cmderdev/cmder/releases/download/1.3.13/cmder_mini.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$BinPath = Join-Path $InstallationPath "Cmder.exe"
Install-BinFile -Name "Cmder" -Path $BinPath
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Cmder.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinPath -WorkingDirectory $InstallationPath
