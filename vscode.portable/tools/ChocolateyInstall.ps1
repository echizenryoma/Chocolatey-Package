$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://vscode-update.azurewebsites.net/latest/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = 'd61bd3e122a8d0872acd346e5fd0fa98a87c0876c34966b31ca2a3004c29d1dc'
$Url64 = 'https://vscode-update.azurewebsites.net/latest/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = '64db94c15b3b998e0c3a3186af4adf5a812d591b510cc1a72187ce3741a82e04'
$InstallationPath = Join-Path $(Get-ToolsLocation) 'vscode'

Get-ChildItem -Path $InstallationPath -Exclude data -ErrorAction Ignore | Remove-Item -Recurse -Force -ErrorAction Ignore
New-Item -ItemType Directory -Path $InstallationPath -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    ChecksumType   = $ChecksumType32
    Checksum       = $Checksum32
    Url64          = $Url64
    ChecksumType64 = $ChecksumType64
    Checksum64     = $Checksum64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$BinPath = Join-Path $InstallationPath "Code.exe"
Install-BinFile -Name Code -Path $BinPath
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Visual Studio Code.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinPath -WorkingDirectory $InstallationPath
