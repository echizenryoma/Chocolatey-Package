$ErrorActionPreference = 'Stop';

$PackageName = 'openssl'
$InstallationPath = Get-ToolsLocation

$OpenSSL_HOME = Join-Path $InstallationPath $PackageName
if (Test-Path $OpenSSL_HOME) {
    Remove-Item -Path $OpenSSL_HOME -Recurse -Force
}