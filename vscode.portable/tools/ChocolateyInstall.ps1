$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://update.code.visualstudio.com/1.73.0/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = '3164867a4fb1bc13b4f6da6024d309acd9e87e60f85fdf4adf78d18f20e83f33'
$Url64 = 'https://update.code.visualstudio.com/1.73.0/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = '0df1b9f88b45e475ffe407da91be97f45ff250aff29e9918edf5fc8f0b6f8080'
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
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $LinkPath = Join-Path $([Environment]::GetFolderPath("DesktopDirectory")) "Visual Studio Code.lnk"
}
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinPath -WorkingDirectory $InstallationPath
