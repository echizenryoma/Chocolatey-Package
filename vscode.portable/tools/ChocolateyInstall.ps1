$ErrorActionPreference = 'Stop'

$PackageName = 'vscode.portable'
$Url = 'https://az764295.vo.msecnd.net/stable/41abd21afdf7424c89319ee7cb0445cc6f376959/VSCode-win32-ia32-1.15.1.zip'
$Url64 = 'https://az764295.vo.msecnd.net/stable/41abd21afdf7424c89319ee7cb0445cc6f376959/VSCode-win32-x64-1.15.1.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
