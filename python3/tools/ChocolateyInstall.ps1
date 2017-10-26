$ErrorActionPreference = 'Stop'

$PackageName = 'python3'
$Url32 = 'https://www.python.org/ftp/python/3.6.3/python-3.6.3.exe'
$Url64 = 'https://www.python.org/ftp/python/3.6.3/python-3.6.3-amd64.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

# This file should be identical for all python3* packages
# https://docs.python.org/3/using/windows.html#installing-without-ui
$InstallArgs = '/quiet InstallAllUsers=1 PrependPath=1 TargetDir="{0}"' -f $InstallationPath

$PackageArgs = @{
    PackageName = $PackageName
    SilentArgs  = $InstallArgs
    Url         = $Url32
    Url64       = $Url64
}
Install-ChocolateyPackage @PackageArgs

$PythonBin = $(Join-Path $InstallationPath 'python.exe')
$Python3Bin = $(Join-Path $InstallationPath 'python3.exe')
if (-Not (Test-Path $Python3Bin)) {
    Start-ChocolateyProcessAsAdmin -ExeToRun 'cmd' -Statements "/c mklink /h `"$Python2Bin`" `"$PythonBin`""
}
