$ErrorActionPreference = 'Stop'

$PackageName = 'hxd'
$Url32 = 'https://mh-nexus.de/downloads/HxDSetup.zip'
$Checksum32 = '7df6eeac31db0992bbbcda9e5a140861d971e82d'
$ChecksumType32 = 'SHA1'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Checksum      = $Checksum32
    ChecksumType  = $ChecksumType32
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

$SetupPath = (Get-ChildItem -Path $ToolsPath -Filter "*Setup.exe" | Select-Object -First 1).FullName
$SetupInfPath = Join-Path $ToolsPath 'setup.inf'
(Get-Content $SetupInfPath).Replace('[InstallationPath]', $ToolsPath) | Set-Content $SetupInfPath
$SilentArgs = "/verysilent /norestart /LoadInf=`"$SetupInfPath`""

$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $SetupPath
    SilentArgs   = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs

Remove-Item $SetupPath -Force -ErrorAction Ignore
Get-ChildItem $ToolsPath -File -Include "unins*.exe" -Recurse | ForEach-Object { $null = New-Item "$($_.FullName).ignore" -Type File -Force }
