$ErrorActionPreference = 'Stop'

$PackageName = 'python3'
$Url32 = 'https://www.python.org/ftp/python/3.7.3/python-3.7.3.exe'
$Url64 = 'https://www.python.org/ftp/python/3.7.3/python-3.7.3-amd64.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

# This file should be identical for all python3* packages
# https://docs.python.org/3/using/windows.html#installing-without-ui
$InstallArgs = '/quiet InstallAllUsers=1 PrependPath=1 AssociateFiles=0 Include_launcher=0 Include_tcltk=0 TargetDir="{0}"' -f $InstallationPath

$PackageArgs = @{
    PackageName = $PackageName
    Url         = $Url32
    Url64       = $Url64
    SilentArgs  = $InstallArgs
}
Install-ChocolateyPackage @PackageArgs

$PythonBin = $(Join-Path $InstallationPath 'python.exe')
$Python3Bin = $(Join-Path $InstallationPath 'python3.exe')
if (-Not (Test-Path $Python3Bin)) {
    New-Item -Path $Python3Bin -ItemType HardLink -Value $PythonBin
}
