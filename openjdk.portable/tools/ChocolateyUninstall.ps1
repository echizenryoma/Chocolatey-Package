$JavaBinPath = Join-Path $Env:JAVA_HOME "bin"

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -ne $JavaBinPath
[Environment]::SetEnvironmentVariable('Path', $EnvPath -join ';', [EnvironmentVariableTarget]::Machine)
Uninstall-ChocolateyEnvironmentVariable -VariableName 'JAVA_HOME' -VariableType 'Machine'
