$ErrorActionPreference = 'Stop';

$InstallationPath = Join-Path $env:ChocolateyToolsLocation "go"
Remove-Item $InstallationPath -Recurse -Force

Uninstall-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableType 'Machine'
Uninstall-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableType 'Machine'

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch '\\go\\'
[Environment]::SetEnvironmentVariable('Path', $EnvPath -join ';', [EnvironmentVariableTarget]::Machine)