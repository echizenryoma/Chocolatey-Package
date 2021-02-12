$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = $ToolsPath

$ExeFiles = Get-ChildItem -Path $InstallationPath -Name "*.exe" -Recurse -ErrorAction SilentlyContinue | Where-Object { !$_.PSIsContainer }
if ($ExeFiles.Count){
    foreach ($exe in $ExeFiles) {
        $ProcessName = [IO.Path]::GetFileNameWithoutExtension(($exe))
        Remove-Process -NameFilter $ProcessName -WaitFor 5
    }
}
