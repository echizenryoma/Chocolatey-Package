$PackageName = 'cmder'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

# Remove from PATH of System
$envPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine) -split ";"
$envPath = $envPath -notmatch $ToolsPath
[Environment]::SetEnvironmentVariable('Path', $envPath, [System.EnvironmentVariableTarget]::Machine)

if (Test-Path $ToolsPath) {
    Remove-Item -Path $ToolsPath -Recurse -Force
}
