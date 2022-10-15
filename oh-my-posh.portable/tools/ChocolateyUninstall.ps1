$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = (Get-Item -Path $ToolsPath).FullName
Remove-Item $InstallationPath -Recurse -Force -ErrorAction Ignore

Uninstall-ChocolateyEnvironmentVariable -VariableName 'POSH_THEMES_PATH' -VariableType 'Machine'
