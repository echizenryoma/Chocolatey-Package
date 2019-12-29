$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://vscode-update.azurewebsites.net/1.41.1/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = '7be4c4d248eac136878fbbe6fc9c428a3c25ffe95969184b4107a214d6ac1c39'
$Url64 = 'https://vscode-update.azurewebsites.net/1.41.1/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = 'e807f9ac8549f80760c980635edb8e1de9104c7a9778c71ea5671af0810a4557'
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
