$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition
$InstallationPath = $ToolsPath

. $(Join-Path $ToolsPath "StopProcess.ps1")

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore