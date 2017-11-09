$ErrorActionPreference = 'Stop'

$PackageName = 'vscode.portable'
$Url = 'https://vscode.cdn.azure.cn/stable/dcee2202709a4f223185514b9275aa4229841aa7/VSCode-win32-ia32-1.18.0.zip'
$Url64 = 'https://vscode.cdn.azure.cn/stable/dcee2202709a4f223185514b9275aa4229841aa7/VSCode-win32-x64-1.18.0.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) 'vscode'

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
Install-BinFile -Name Code -Path $(Join-Path $InstallationPath "Code.exe")
Install-ChocolateyShortcut -ShortcutFilePath "$Env:SystemDrive\Users\Public\Desktop\Visual Studio Code.lnk" -TargetPath $(Join-Path $InstallationPath "Code.exe") 
