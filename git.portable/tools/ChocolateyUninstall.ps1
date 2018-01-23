$PackageName = 'git'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine) -split ";"
$EnvPath = $EnvPath -notmatch $ToolsPath
[Environment]::SetEnvironmentVariable('Path', $EnvPath, [System.EnvironmentVariableTarget]::Machine)

Remove-Item -Path $ToolsPath -Recurse -Force -ErrorAction Ignore