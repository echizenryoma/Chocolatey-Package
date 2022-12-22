$ErrorActionPreference = 'Stop'

$PackageName = 'oh-my-posh'
$Url32 = 'https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v12.28.2/posh-windows-386.exe'
$Url64 = 'https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v12.28.2/posh-windows-amd64.exe'
$UrlExtra = 'https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v12.28.2/themes.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = (Get-Item -Path $ToolsPath).FullName

$BinPath = Join-Path $InstallationPath 'bin'
$FileFullPath = Join-Path $BinPath "${PackageName}.exe"
$PackageArgs = @{
    PackageName  = $PackageName
    Url32        = $Url32
    Url64        = $Url64
    FileFullPath = $FileFullPath
}
Get-ChocolateyWebFile @PackageArgs

$ThemesPath = Join-Path $InstallationPath 'themes'
$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $UrlExtra
    UnzipLocation = $ThemesPath
}
Install-ChocolateyZipPackage @PackageArgs
Install-ChocolateyEnvironmentVariable -VariableName 'POSH_THEMES_PATH' -VariableValue $ThemesPath -VariableType 'Machine'
