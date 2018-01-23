$ErrorActionPreference = 'Stop'

$PackageName = 'xftp'
$Url = 'https://www.netsarang.com/beta/download.php?id=xfp'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$SetupIssPath = Join-Path $ToolsPath 'setup.iss'
(Get-Content $SetupIssPath).replace('[InstallationPath]', $InstallationPath) | Set-Content $SetupIssPath

$PackageArgs = @{
    PackageName = $PackageName    
    Url         = $Url
    FileType    = "EXE"
    SilentArgs  = "/S /f1`"$SetupIssPath`""
}
Install-ChocolateyPackage @PackageArgs
