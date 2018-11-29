$ErrorActionPreference = 'Stop'

$PackageName = 'navicat'
$Url32 = 'http://download.navicat.com.cn/download/navicat121_premium_cs_x86.exe'
$Url64 = 'http://download.navicat.com.cn/download/navicat121_premium_cs_x64.exe'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item -Path $InstallationPath -Recurse -Force -ErrorAction Ignore

$FilePath = Join-Path $ToolsPath $([IO.Path]::GetFileName($Url32))
$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url32
    Url64        = $Url64
    FileFullPath = $FilePath
}
Get-ChocolateyWebFile @PackageArgs

$UnzipPath = Join-Path $ToolsPath "tmp"
$null = New-Item -Path $UnzipPath -ItemType Directory -Force -ErrorAction Ignore

$InstallArgs = '-x -d"{0}" "{1}"' -f $UnzipPath, $FilePath
Start-ChocolateyProcessAsAdmin -ExeToRun 'innounp' -Statements $InstallArgs
Remove-Item -Path $FilePath -Force -ErrorAction Ignore

$AppPath = Join-Path $UnzipPath '{app}'
Rename-Item -Path $AppPath -NewName $PackageName -Force
$AppPath = Join-Path $UnzipPath $PackageName
Move-Item -Path $AppPath -Destination $(Get-ToolsLocation) -Force
Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore

$KeygenPath = [IO.Path]::Combine($ToolsPath, "..", "..", "navicat-keygen", "tools")
$RegPrivateKeyPath = Join-Path $KeygenPath "RegPrivateKey.pem"
$PatchArgs = '"{0}" "{1}"' -f $InstallationPath, $RegPrivateKeyPath
Start-ChocolateyProcessAsAdmin -ExeToRun 'navicat-patcher' -Statements $PatchArgs

$BinFileName = Join-Path $InstallationPath "${PackageName}.exe"
Install-BinFile -Name 'Navicat Premium' -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Navicat Premium.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
