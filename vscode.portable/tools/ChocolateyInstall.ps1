$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://update.code.visualstudio.com/1.66.0/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = '49a4db35002fafbe1fff869233c66f0e514a8477a941416ba6fd87c5393ef113'
$Url64 = 'https://update.code.visualstudio.com/1.66.0/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = 'f2946898aaf3f1d83a22fc27d9b4e59aa90b39531d92e11aec8d08cd9033f43c'
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
