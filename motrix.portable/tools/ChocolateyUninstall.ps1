$PackageName = 'Motrix'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

. $(Join-Path $ToolsPath "StopProcess.ps1")

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
Uninstall-BinFile -Name ${PackageName}

$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore