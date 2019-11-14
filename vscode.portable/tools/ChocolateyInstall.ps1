$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://vscode-update.azurewebsites.net/1.40.1/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = '19476c36689f62a41e475c25b8cda440c4ea04d0a5b2db650a1bfb0811dd88f1'
$Url64 = 'https://vscode-update.azurewebsites.net/1.40.1/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = 'c54e5f1f897b0d7a1577fc526ce2abf05f200ad3b77c2c78b0c9d6b397423a3b'
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

$BinPath = Join-Path $InstallationPath "bin\code.cmd"
Install-BinFile -Name Code -Path $BinPath
$BinPath = Join-Path $InstallationPath "Code.exe"
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Visual Studio Code.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinPath -WorkingDirectory $InstallationPath
