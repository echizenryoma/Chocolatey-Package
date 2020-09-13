$PackageName = 'qv2ray'

. $(Join-Path $ToolsPath "StopProcess.ps1")

$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$Qv2rayPath = Join-Path $(Get-ToolsLocation) $PackageName
$Qv2rayConfigPath = Join-Path $Qv2rayPath 'config'
$Qv2rayPluginPath = Join-Path $Qv2rayConfigPath 'plugin'
$InstallationPath = (Get-ChildItem -Path $Qv2rayPluginPath -Recurse -File | Where-Object Name -Match "QvTrojanPlugin.*.dll" | Select-Object -First 1).FullName

Remove-Item $InstallationPath -Force -ErrorAction Ignore
