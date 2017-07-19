$ErrorActionPreference = 'Stop'

$PackageName = 'vscode.portable'
$Url = 'https://az764295.vo.msecnd.net/stable/2648980a697a4c8fb5777dcfb2ab110cec8a2f58/VSCode-win32-ia32-1.14.1.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
