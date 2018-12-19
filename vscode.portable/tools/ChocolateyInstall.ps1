$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://vscode-update.azurewebsites.net/latest/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = '12cb41dc9b187b0f43a87dd83b22125b6dd9c92df49cd3c7eec45f12f3925e80'
$Url64 = 'https://vscode-update.azurewebsites.net/latest/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = 'a5650ace744c51c1ab90c1f03e8bbd6f15f11efbec5391bb256814b351fcc814'
$InstallationPath = Join-Path $(Get-ToolsLocation) 'vscode'

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
