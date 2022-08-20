$ErrorActionPreference = 'Stop'

$PackageName = 'npcap'
$Url32 = 'https://nmap.org/npcap/dist/npcap-1.71.exe'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$DownloadPath = Join-Path $ToolsPath "tmp"

$FileName = [IO.Path]::GetFileName($Url32)
$BinPath = Join-Path $DownloadPath $FileName
$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url32
    FileFullPath = $BinPath
}
Get-ChocolateyWebFile @PackageArgs

Write-Output "Running Autohotkey installer"

$AhkScript = Join-Path $ToolsPath "${PackageName}.ahk"
& AutoHotkey "$AhkScript" install "$BinPath"

Remove-Item -Path $DownloadPath -Force -Recurse -ErrorAction Ignore
