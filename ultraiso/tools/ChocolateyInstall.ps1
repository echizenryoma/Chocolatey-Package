$ErrorActionPreference = 'Stop'

$PackageName = 'ultraiso'
$Url = 'http://reg.ezbsys.com/private/3939p575/uiso97pes.exe'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$SetupInfPath = Join-Path $ToolsPath 'setup.inf'
$SilentArgs = "/verysilent /norestart /LoadInf=`"$SetupInfPath`""

$PackageArgs = @{
    PackageName = $PackageName
    Url         = $Url
    SilentArgs  = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs

$InstallationPath = (Get-InstallRegistryKey "ultraiso*" | Select-Object -First 1).InstallLocation
Copy-Item -Path $(Join-Path $ToolsPath "uikey.ini") -Destination $InstallationPath
