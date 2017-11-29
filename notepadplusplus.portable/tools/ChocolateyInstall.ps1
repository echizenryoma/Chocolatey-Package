$ErrorActionPreference = 'Stop'

$PackageName = 'notepadplusplus'
$Url = 'https://notepad-plus-plus.org/repository/7.x/7.5.2/npp.7.5.2.bin.7z'
$Checksum = 'e91fadf247b0232b7f1a9e567f2844a763a8e3f3'
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

$UrlExtra = 'https://notepad-plus-plus.org/repository/7.x/7.5.2/npp.7.5.2.Installer.exe'
$FileName = [IO.Path]::GetFileName($UrlExtra)
$InstallerPath = Join-Path $InstallationPath $FileName
$PackageArgs = @{
    Url      = $UrlExtra
    FileName = $InstallerPath
}
Get-WebFile @PackageArgs
$content = 7z.exe l "$InstallerPath" "NppShell_*.dll"
$NppShellFileName = $content -split "\n| " -match "NppShell" | Select-Object -First 1
if (!(Test-Path $(Join-Path $InstallationPath $NppShellFileName))) {
    7z.exe e "$installer" -y -aos "$NppShellFileName" -o"$InstallationPath"
}
regsvr32.exe /s "$(Join-Path $InstallationPath $NppShellFileName)"
Remove-Item -Path $InstallerPath -Force

Install-BinFile -Name 'notepad++' -Path $(Join-Path $InstallationPath "notepad++.exe")
Install-ChocolateyShortcut -ShortcutFilePath "$Env:SystemDrive\Users\Public\Desktop\Notepad++.lnk" -TargetPath $(Join-Path $InstallationPath "notepad++.exe") 
