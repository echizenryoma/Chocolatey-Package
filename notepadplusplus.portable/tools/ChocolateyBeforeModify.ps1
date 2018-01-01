$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$NppShell = Join-Path $InstallationPath "NppShell_06.dll"
if (Test-Path $NppShell) {
    Start-ChocolateyProcessAsAdmin -ExeToRun 'regsvr32' -Statements "/s /u `"$NppShell`""
}