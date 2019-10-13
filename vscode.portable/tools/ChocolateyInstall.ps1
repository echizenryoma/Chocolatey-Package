$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Version = '1.39.1'
$Url32 = 'https://vscode-update.azurewebsites.net/' + $Version + '/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = 'fe25244cbc5474335f5f83b4f6bf16cefa7b58dd3a1ba63a1e4607470f291d2c'
$Url64 = 'https://vscode-update.azurewebsites.net/' + $Version + '/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = '7ea542a5ba4f307123b6a3a21fc4eab103b28291a3d91b817f08d5102d270b3e'
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
