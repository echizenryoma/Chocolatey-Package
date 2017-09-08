$ErrorActionPreference = 'Stop'

$PackageName = 'vscode.portable'
$Url = 'https://az764295.vo.msecnd.net/stable/787b31c0474e6165390b5a5989c9619e3e16f953/VSCode-win32-ia32-1.16.0.zip'
$Url64 = 'https://az764295.vo.msecnd.net/stable/787b31c0474e6165390b5a5989c9619e3e16f953/VSCode-win32-x64-1.16.0.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
