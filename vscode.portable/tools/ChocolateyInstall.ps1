$ErrorActionPreference = 'Stop'

$PackageName = 'vscode.portable'
$Url = 'https://vscode.cdn.azure.cn/stable/490ef761b76b3f3b3832eff7a588aac891e5fe80/VSCode-win32-ia32-1.19.2.zip'
$Url64 = 'https://vscode.cdn.azure.cn/stable/490ef761b76b3f3b3832eff7a588aac891e5fe80/VSCode-win32-x64-1.19.2.zip'
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
