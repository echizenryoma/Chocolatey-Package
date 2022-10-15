$ErrorActionPreference = 'Stop'

$PackageName = 'oh-my-posh'
$Url64 = 'https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v12.3.0/posh-windows-amd64.7z'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = (Get-Item -Path $ToolsPath).FullName

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$ThemesPath = Join-Path $InstallationPath 'themes'
Install-ChocolateyEnvironmentVariable -VariableName 'POSH_THEMES_PATH' -VariableValue $ThemesPath -VariableType 'Machine'
