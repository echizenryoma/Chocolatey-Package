$ErrorActionPreference = 'Stop'

$PackageName = 'mpc-be'
$Url32 = 'https://sourceforge.net/projects/mpcbe/files/MPC-BE/Release%20builds/1.5.1/MPC-BE.1.5.1.x86-installer.zip'
$Url64 = 'https://sourceforge.net/projects/mpcbe/files/MPC-BE/Release%20builds/1.5.1/MPC-BE.1.5.1.x64-installer.zip'
$ToolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url32         = $Url32
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @packageArgs

$InstallerPath = Get-ChildItem $ToolsPath -Recurse -Include *.exe | Select-Object -Last 1

$SetupInfPath = Join-Path $ToolsPath 'setup.inf'
$SilentArgs = "/verysilent /norestart /LoadInf=`"$SetupInfPath`""

$PackageArgs = @{
    PackageName = $PackageName
    Url32       = $InstallerPath
    Url64       = $InstallerPath
    SilentArgs  = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs
Remove-Item -Path $InstallerPath -Force -ErrorAction Ignore
