$PackageName = 'qv2ray'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$Qv2rayPath = Join-Path $(Get-ToolsLocation) $PackageName
$Qv2rayConfigPath = Join-Path $Qv2rayPath 'config'
$InstallationPath = Join-Path $Qv2rayConfigPath 'vcore'

. $(Join-Path $ToolsPath "StopProcess.ps1")

Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore
