﻿$ErrorActionPreference = 'Stop'

$PackageName = 'LibreOffice'
$Url32 = 'https://mirrors.ustc.edu.cn/tdf/libreoffice/stable/6.3.1/win/x86/LibreOffice_6.3.1_Win_x86.msi'
$Url64 = 'https://mirrors.ustc.edu.cn/tdf/libreoffice/stable/6.3.1/win/x86_64/LibreOffice_6.3.1_Win_x64.msi'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item -Path $InstallationPath -Recurse -Force -ErrorAction Ignore

$FilePath = Join-Path $ToolsPath $([IO.Path]::GetFileName($Url32))
if ((Get-ProcessorBits 64) -and (-not ($env:chocolateyForceX86))) {
    $FilePath = Join-Path $ToolsPath $([IO.Path]::GetFileName($Url64))
}
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
