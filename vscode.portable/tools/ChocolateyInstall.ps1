$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://update.code.visualstudio.com/1.69.1/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = '7eb9d522de95b0c1f888bcfd71ec86c2efde36ae7feb7d417b2142107324e17f'
$Url64 = 'https://update.code.visualstudio.com/1.69.1/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = '7c17395bc5d2663cab17f421540fc122574bbbbd2a5eaf87450c80bb9b322d93'
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
