$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://vscode-update.azurewebsites.net/1.42.0/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = 'a8dfe39da22c1af732d9c18aa90af0009e337fe073e83e36fe17bece70ba044d'
$Url64 = 'https://vscode-update.azurewebsites.net/1.42.0/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = '29b9b746e4e623f54674b01dafa6984895c9ac356c7f7a406f4d29dbe422818d'
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
