$ErrorActionPreference = 'Stop';

$installationPath = Join-Path $env:ChocolateyToolsLocation "go"
Remove-Item $installationPath -Recurse -Force

Uninstall-ChocolateyEnvironmentVariable -VariableName 'GOROOT' -VariableType 'Machine'
Uninstall-ChocolateyEnvironmentVariable -VariableName 'GOPATH' -VariableType 'Machine'

$envPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch '\\go\\'
[Environment]::SetEnvironmentVariable('Path', $envPath -join ';', [EnvironmentVariableTarget]::Machine)