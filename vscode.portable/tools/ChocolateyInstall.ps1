$ErrorActionPreference = 'Stop'

$PackageName = 'vscode'
$Url32 = 'https://update.code.visualstudio.com/1.55.2/win32-archive/stable'
$ChecksumType32 = 'sha256'
$Checksum32 = '7fa464f315de5927fbf165e69709ffe837d535c28a015145007cf545d17378d9'
$Url64 = 'https://update.code.visualstudio.com/1.55.2/win32-x64-archive/stable'
$ChecksumType64 = 'sha256'
$Checksum64 = '7a112a19d98c4645cf806f857f340c2ad0fd7f45122e1325c97c7c3be2abfdd0'
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
