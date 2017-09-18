$ErrorActionPreference = 'Stop'

$PackageName = 'vscode.portable'
$Url = 'https://az764295.vo.msecnd.net/stable/27492b6bf3acb0775d82d2f87b25a93490673c6d/VSCode-win32-ia32-1.16.1.zip'
$Url64 = 'https://az764295.vo.msecnd.net/stable/27492b6bf3acb0775d82d2f87b25a93490673c6d/VSCode-win32-x64-1.16.1.zip'
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
