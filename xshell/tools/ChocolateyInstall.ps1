$ErrorActionPreference = 'Stop'

$PackageName = 'xshell'
$Url = 'https://cdn.netsarang.net/69322a12/Xshell-6.0.0070r_beta.exe'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$SetupIssPath = Join-Path $ToolsPath 'setup.iss'
(Get-Content $SetupIssPath).replace('[InstallationPath]', $InstallationPath) | Set-Content $SetupIssPath

$PackageArgs = @{
    PackageName = $PackageName
    Url         = $Url
    SilentArgs  = "/S /f1`"$SetupIssPath`""
}
Install-ChocolateyPackage @PackageArgs
