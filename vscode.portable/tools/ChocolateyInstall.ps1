$ErrorActionPreference = 'Stop'

$PackageName = 'vscode.portable'
$Url = 'https://az764295.vo.msecnd.net/stable/8b95971d8cccd3afd86b35d4a0e098c189294ff2/VSCode-win32-ia32-1.15.0.zip'
$Url64 = 'https://az764295.vo.msecnd.net/stable/8b95971d8cccd3afd86b35d4a0e098c189294ff2/VSCode-win32-x64-1.15.0.zip'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

Get-ChildItem $ToolsPath -Include "*.exe" -Exclude "Code.exe" -Recurse | ForEach-Object { New-Item "$($_.FullName).ignore" -Type file -Force | Out-Null }
