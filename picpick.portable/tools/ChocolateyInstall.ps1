$ErrorActionPreference = 'Stop'

$PackageName = 'picpick'
$Url32 = 'https://picpick.app/download/latest/picpick_portable.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "picpick.exe" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type file -Force }

$BinPath = Join-Path $ToolsPath "${PackageName}.exe"
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "PicPick.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinPath -WorkingDirectory $InstallationPath
