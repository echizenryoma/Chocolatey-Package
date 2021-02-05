$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://vscode-update.azurewebsites.net/1.53.0/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = '2744512315e95c4297bea81b2efc006a4800b39cdea36359d5b9d4e24fd19a26'
$Url64 = 'https://vscode-update.azurewebsites.net/1.53.0/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = 'e96514a097d0f2c2125bee7a019ea4d37e626772309f8ef761c92cde3c5f2420'
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
