$PackageName = 'mitmproxy'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

. $(Join-Path $ToolsPath "StopProcess.ps1")

Remove-Item $ToolsPath -Recurse -Force -ErrorAction Ignore
