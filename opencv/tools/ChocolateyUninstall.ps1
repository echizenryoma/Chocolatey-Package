$ErrorActionPreference = 'Stop';

$OpenCV_HOME = Join-Path $(Get-ToolsLocation) 'opencv'
Remove-Item $OpenCV_HOME -Recurse -Force

$envPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch 'opencv'
[Environment]::SetEnvironmentVariable('Path', $envPath -join ';', [EnvironmentVariableTarget]::Machine)

Uninstall-ChocolateyEnvironmentVariable -VariableName 'OpenCV_DIR' -VariableType 'Machine'
Uninstall-ChocolateyEnvironmentVariable -VariableName 'OpenCV_LIBS' -VariableType 'Machine'
Uninstall-ChocolateyEnvironmentVariable -VariableName 'OpenCV_INCLUDE_DIRS' -VariableType 'Machine'
