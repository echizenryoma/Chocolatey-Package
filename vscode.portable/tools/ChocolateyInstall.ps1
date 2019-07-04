$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://vscode-update.azurewebsites.net/latest/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = 'f64908d21344dc28ef6837a6eb000090c7729182d608602b468ea6d6fddacca7'
$Url64 = 'https://vscode-update.azurewebsites.net/latest/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = '0fab4ea393aef54cc77175d548fc01f49b59c3ee7392f5b9e361d6c2535a75f7'
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
