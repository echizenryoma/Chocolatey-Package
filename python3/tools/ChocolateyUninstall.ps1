$PackageName = 'python3'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

if (Test-Path $InstallationPath) {
    Remove-Item $InstallationPath -Recurse -Force
}
