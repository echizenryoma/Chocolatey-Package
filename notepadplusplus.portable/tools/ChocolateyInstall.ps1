$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$Url = 'https://notepad-plus-plus.org/repository/7.x/7.5.3/npp.7.5.3.bin.7z'
$Checksum = 'ddcdfe363d4539e36e9a0e0acba71ab88c350087'
$ChecksumType = 'sha1'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$UrlExtra = 'https://notepad-plus-plus.org/repository/7.x/7.5.3/npp.7.5.3.Installer.exe'
$FileName = [IO.Path]::GetFileName($UrlExtra)
$InstallerPath = Join-Path $InstallationPath $FileName
$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $UrlExtra
    FileFullPath = $InstallerPath
}
Get-ChocolateyWebFile @PackageArgs
$content = Start-ChocolateyProcessAsAdmin -ExeToRun 'cmd' -Statements "/c 7z l `""$InstallerPath"`" `"NppShell_*.dll`""
$NppShellFileName = $content -split "\n| " -match "NppShell" | Select-Object -First 1
if (!(Test-Path $(Join-Path $InstallationPath $NppShellFileName))) {
    Start-ChocolateyProcessAsAdmin -ExeToRun 'cmd' -Statements "/c 7z e `"$InstallerPath`" -y -aos `"$NppShellFileName`" -o`"$InstallationPath`""
}
$NppShell = Join-Path $InstallationPath $NppShellFileName
Start-ChocolateyProcessAsAdmin -ExeToRun 'cmd' -Statements "/c regsvr32 /s `"$NppShell`""
Remove-Item -Path $InstallerPath -Force -ErrorAction Ignore

Install-BinFile -Name 'notepad++' -Path $(Join-Path $InstallationPath "notepad++.exe")
Install-ChocolateyShortcut -ShortcutFilePath "$Env:SystemDrive\Users\Public\Desktop\Notepad++.lnk" -TargetPath $(Join-Path $InstallationPath "notepad++.exe") 
