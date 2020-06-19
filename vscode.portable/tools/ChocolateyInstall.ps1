$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://vscode-update.azurewebsites.net/1.46.1/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = 'c992e85d4fd954d56596894c3fb6e1a9db61d8308328b74c4c15d7d60f2446c2'
$Url64 = 'https://vscode-update.azurewebsites.net/1.46.1/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = '745195e54c0727a5470a77d2ccc5572a9ac770b98d7aaf3013fc29e11c4c9eb5'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$DataPath = Join-Path $InstallationPath 'data'

Get-ChildItem -Path $InstallationPath -Exclude data -ErrorAction Ignore | Remove-Item -Recurse -Force -ErrorAction Ignore
New-Item -ItemType Directory -Path $InstallationPath -Force -ErrorAction Ignore
New-Item -ItemType Directory -Path $DataPath -Force -ErrorAction Ignore

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
