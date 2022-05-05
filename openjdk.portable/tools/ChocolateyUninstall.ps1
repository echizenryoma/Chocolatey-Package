Uninstall-ChocolateyEnvironmentVariable -VariableName 'JAVA_HOME' -VariableType 'Machine'

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch 'jdk'
[Environment]::SetEnvironmentVariable('Path', $EnvPath -join ';', [EnvironmentVariableTarget]::Machine)
