$ErrorActionPreference = 'Stop';

$PackageName = 'tesseract'

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch $PackageName
[Environment]::SetEnvironmentVariable('Path', $EnvPath -join ';', [EnvironmentVariableTarget]::Machine)
Uninstall-ChocolateyEnvironmentVariable -VariableName 'TESSDATA_PREFIX' -VariableType 'Machine'
