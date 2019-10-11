$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Version = '1.39.0'
$Url32 = 'https://vscode-update.azurewebsites.net/' + $Version + '/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = 'a6d4fa21f0fa362daf9021edaad3adbb67a760ba4de8e0b6ee7938144f6d4440'
$Url64 = 'https://vscode-update.azurewebsites.net/' + $Version + '/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = '899300204bf86ae4817050efbd21c495e769f2069d1aca0062eca931230562ee'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

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
