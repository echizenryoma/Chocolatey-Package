$ErrorActionPreference = 'Stop'

$PackageName = 'python3'
$Url32 = 'https://www.python.org/ftp/python/3.6.4/python-3.6.4.exe'
$Url64 = 'https://www.python.org/ftp/python/3.6.4/python-3.6.4-amd64.exe'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$FilePath = Join-Path $ToolsPath $([IO.Path]::GetFileName($Url32))
$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url32
    Url64        = $Url64
    FileFullPath = $FilePath
}
Get-ChocolateyWebFile @PackageArgs

$InstallArgs = '/c msiexec /a "{0}" /qn TargetDir="{1}"' -f $FilePath, $InstallationPath
Start-ChocolateyProcessAsAdmin -ExeToRun 'cmd' -Statements $InstallArgs
Remove-Item -Path $FilePath -Force -ErrorAction Ignore

$PythonBin = $(Join-Path $InstallationPath 'python.exe')
$Python3Bin = $(Join-Path $InstallationPath 'python3.exe')
if (-Not (Test-Path $Python3Bin)) {
    Start-ChocolateyProcessAsAdmin -ExeToRun 'cmd' -Statements "/c mklink /h `"$Python3Bin`" `"$PythonBin`""
}

Install-ChocolateyPath $InstallationPath 'Machine'
Install-ChocolateyPath $(Join-Path $InstallationPath "Scripts") 'Machine'