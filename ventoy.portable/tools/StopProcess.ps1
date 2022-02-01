$PackageName = 'ventoy'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$ExeFiles = Get-ChildItem -Path $InstallationPath -Name "*.exe" -Recurse -ErrorAction SilentlyContinue | Where-Object { !$_.PSIsContainer }
if ($ExeFiles.Count){
    foreach ($exe in $ExeFiles) {
        $ProcessName = [IO.Path]::GetFileNameWithoutExtension(($exe))
        $Process = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
        if ($Process) {
            Write-Host "Stopping the running process: $exe ..."
            $Process | Stop-Process -Force
        }
    }
}
