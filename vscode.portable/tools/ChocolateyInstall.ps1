$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://update.code.visualstudio.com/1.61.0/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = 'aa7f9dff54df5cad6447f2e4acfe9d692a1d7eabf865b753711c0de29441b7bc'
$Url64 = 'https://update.code.visualstudio.com/1.61.0/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = 'cbfaf43c3fc87ae743363feaf595fbb8818517eedc0552d14dea473d00a33ca1'
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
