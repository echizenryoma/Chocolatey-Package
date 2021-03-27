$PackageName = 'electerm'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

. $(Join-Path $ToolsPath "StopProcess.ps1")

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
