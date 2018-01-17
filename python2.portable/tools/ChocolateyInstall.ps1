$ErrorActionPreference = 'Stop'

$PackageName = 'python2'
$Url32 = 'https://www.python.org/ftp/python/2.7.14/python-2.7.14.msi'
$Url64 = 'https://www.python.org/ftp/python/2.7.14/python-2.7.14.amd64.msi'
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

$InstallArgs = '/a "{0}" /qn TargetDir="{1}"' -f $FilePath, $InstallationPath
Start-ChocolateyProcessAsAdmin -ExeToRun 'msiexec' -Statements $InstallArgs
Remove-Item -Path $FilePath -Force -ErrorAction Ignore

$PythonBin = $(Join-Path $InstallationPath 'python.exe')
$Python2Bin = $(Join-Path $InstallationPath 'python2.exe')
if (-Not (Test-Path $Python2Bin)) {
	New-Item -Path $Python2Bin -ItemType HardLink -Value $PythonBin
}

Install-ChocolateyPath $InstallationPath 'Machine'
Install-ChocolateyPath $(Join-Path $InstallationPath "Scripts") 'Machine'
