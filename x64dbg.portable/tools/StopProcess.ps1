$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition
$InstallationPath = $ToolsPath

$ExeFiles = Get-ChildItem -Path $InstallationPath -File -Recurse -Filter "*.exe" -ErrorAction SilentlyContinue
foreach ($ExeFile in $ExeFiles) {
    $ProcessName = [IO.Path]::GetFileNameWithoutExtension(($ExeFile))
    $Process = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
    if ($Process) {
        Write-Host "Stopping the running process: $ExeFile ..."
        $Process | Stop-Process -Force
    }
}