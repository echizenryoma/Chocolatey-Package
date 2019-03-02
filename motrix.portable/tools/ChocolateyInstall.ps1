$ErrorActionPreference = 'Stop'

$PackageName = 'Motrix'
$Url = 'https://github.com/agalwood/Motrix/releases/download/v1.1.3/Motrix-1.1.3-win.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

. $(Join-Path $ToolsPath "StopProcess.ps1")

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$BinFileName = Join-Path $InstallationPath "${PackageName}.exe"
Install-BinFile -Name $PackageName -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
