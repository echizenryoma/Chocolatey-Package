$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
<<<<<<< HEAD
$Url32 = 'https://vscode-update.azurewebsites.net/1.39.2/win32-archive/stable'
$Checksum32 = 'c6f871e594133d9f81b9cca7ccb463ad3ebb265eb666a58541e4b81ee47b1d95'
$Url64 = 'https://vscode-update.azurewebsites.net/1.39.2/win32-x64-archive/stable'
=======
$Version = '1.39.2'
$Url32 = 'https://vscode-update.azurewebsites.net/1.39.2/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = 'c6f871e594133d9f81b9cca7ccb463ad3ebb265eb666a58541e4b81ee47b1d95'
$Url64 = 'https://vscode-update.azurewebsites.net/1.39.2/win32-x64-archive/stable'
>>>>>>> bf85287d07e25a2304c40447f611f2950a38715f
$ChecksumType64 = 'sha256'
$Checksum64 = '3adfc6dc97ca62cd607793ce8a37a1d9ab985fef888d5b622973494d663a09a8'
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
