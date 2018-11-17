$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$NppShell = (Get-ChildItem -Path $InstallationPath -Filter "NppShell_*.dll" | Select-Object -First 1).FullName
if (Test-Path $NppShell) {
    Start-ChocolateyProcessAsAdmin -ExeToRun 'regsvr32' -Statements "/s /u `"$NppShell`""
}