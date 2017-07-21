$ErrorActionPreference = 'Stop';

$PackageName = 'nodejs'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch '\\$PackageName\\'
[Environment]::SetEnvironmentVariable('Path', $EnvPath -join ';', [EnvironmentVariableTarget]::Machine)

if (Test-Path $ToolsPath) {
    Remove-Item -Path $ToolsPath -Recurse -Force
}