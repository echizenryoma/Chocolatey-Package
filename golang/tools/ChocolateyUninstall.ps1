$PackageName = 'go'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore

Uninstall-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableType 'Machine'
Uninstall-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableType 'Machine'

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch "\\$PackageName\\"
[Environment]::SetEnvironmentVariable('Path', $EnvPath -join ';', [EnvironmentVariableTarget]::Machine)