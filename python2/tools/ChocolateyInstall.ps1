$ErrorActionPreference = 'Stop'

$PackageName = 'python2'
$Url32 = 'https://www.python.org/ftp/python/2.7.14/python-2.7.14.msi'
$Url64 = 'https://www.python.org/ftp/python/2.7.14/python-2.7.14.amd64.msi'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

# This file should be identical for all python* packages
# https://docs.python.org/3/using/windows.html#installing-without-ui
$InstallArgs = '/qn /norestart ALLUSERS=1 ADDLOCAL=ALL TargetDir="{0}"' -f $InstallationPath

$PackageArgs = @{
    PackageName = $PackageName
    FileType    = 'msi'
    SilentArgs  = $InstallArgs
    Url         = $Url32
    Url64       = $Url64
}
Install-ChocolateyPackage @PackageArgs
Install-ChocolateyPath $InstallationPath 'Machine'

$PythonBin = $(Join-Path $InstallationPath 'python.exe')
$Python2Bin = $(Join-Path $InstallationPath 'python2.exe')
if (-Not (Test-Path $Python2Bin)) {
    Start-ChocolateyProcessAsAdmin -ExeToRun 'cmd' -Statements "/c mklink /h `"$Python2Bin`" `"$PythonBin`""
}
