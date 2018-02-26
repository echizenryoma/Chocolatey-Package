$ErrorActionPreference = 'Stop'

$PackageName = 'inno-setup'
$Url32 = 'http://www.jrsoftware.org/download.php/is-unicode.exe'
$UrlExtra = 'http://www.jrsoftware.org/download.php/ip015.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$SetupInfPath = Join-Path $ToolsPath 'setup.inf'
(Get-Content $SetupInfPath).replace('%InstallationPath%', $InstallationPath) | Set-Content $SetupInfPath

$SilentArgs = "/verysilent /norestart /LoadInf=`"$SetupInfPath`""

$PackageArgs = @{
    PackageName = $PackageName
    Url         = $Url32
    SilentArgs  = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $UrlExtra
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @packageArgs

Install-BinFile -Path $(Join-Path $InstallationPath 'ISCC.exe') -Name 'ISCC'
