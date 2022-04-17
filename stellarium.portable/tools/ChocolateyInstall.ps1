$ErrorActionPreference = 'Stop'

$PackageName = 'stellarium'
$Url32 = 'https://github.com/Stellarium/stellarium/releases/download/v0.22.1/stellarium-0.22.1-win32.exe'
$Url64 = 'https://github.com/Stellarium/stellarium/releases/download/v0.22.1/stellarium-0.22.1-win64.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$TmpPath = Join-Path $InstallationPath "tmp"

$BinPath = Join-Path $TmpPath "$PackageName-setup.exe"
$PackageArgs = @{
    PackageName  = $PackageName
    Url32        = $Url32
    Url64        = $Url64
    FileFullPath = $BinPath
}
Get-ChocolateyWebFile @PackageArgs

& innoextract.exe -e "$BinPath" -d "$TmpPath"

$AppPath = Join-Path $TmpPath 'app'
Get-ChildItem -Path $AppPath -Recurse | Move-Item -Destination $InstallationPath

Remove-Item -Path $TmpPath -Force -Recurse

$BinFile = Join-Path $InstallationPath "${PackageName}.exe"
Install-BinFile -Path $BinFile -Name "${PackageName}"
