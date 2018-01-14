$PackageName = 'cmder'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch $InstallationPath
[Environment]::SetEnvironmentVariable('Path', $EnvPath -join ';', [EnvironmentVariableTarget]::Machine)

Remove-Item -Path $InstallationPath -Recurse -Force -ErrorAction Ignore
