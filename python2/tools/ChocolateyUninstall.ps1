$PackageName = 'python2'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

if (Test-Path $InstallationPath) {
    Remove-Item $InstallationPath -Recurse -Force
}

$EnvPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine) -split ';' -notmatch "$PackageName"
[Environment]::SetEnvironmentVariable('Path', $EnvPath -join ';', [EnvironmentVariableTarget]::Machine)