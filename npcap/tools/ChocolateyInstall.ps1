$ErrorActionPreference = 'Stop'

$PackageName = 'npcap'
$Url32 = 'https://nmap.org/npcap/dist/npcap-1.71.exe'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$DownloadPath = (Get-Item -Path $ToolsPath).FullName

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

Get-ChildItem $ToolsPath -Include "*.exe" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type file -Force }
