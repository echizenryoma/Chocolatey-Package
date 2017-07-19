$ErrorActionPreference = 'Stop';

$envPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch 'openssl'
[Environment]::SetEnvironmentVariable('Path', $envPath -join ';', [EnvironmentVariableTarget]::Machine)

Uninstall-ChocolateyEnvironmentVariable -VariableName 'OPENSSL_ROOT_DIR' -VariableType 'Machine'
