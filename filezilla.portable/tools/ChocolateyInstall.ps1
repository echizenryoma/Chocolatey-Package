$ErrorActionPreference = 'Stop'

$PackageName = 'FileZilla'
$Page = Invoke-WebRequest -UseBasicParsing -Uri 'https://filezilla-project.org/download.php?show_all=1'
$Url32 = $page.Links.href -match "win32\.zip" | Select-Object -First 1
$Checksum32 = '0e2a262a5dd6a565588ba4c0865d5e7b7afcc8c96ac85827025492dbab6204ff0fc7be95482fa0f3d0e32c95d90941c83ef07b136d86672b5cabff8bc99277d6'
$ChecksumType32 = 'sha512'
$Url64 = $page.Links.href -match "win64\.zip" | Select-Object -First 1
$Checksum64 = '71ef08eb09ae6a91ec65f7a0563a7dce595e53079ef10652194c48a8cd9f759320f6b2290cb300d80093ef1cb8b357e5eb935e5f0c3b938ecc180d81142fc441'
$ChecksumType64 = 'sha512'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Get-ToolsLocation

Remove-Item -Path $InstallationPath -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Checksum       = $Checksum32
    ChecksumType   = $ChecksumType32
    Url64          = $Url64
    Checksum64     = $Checksum64
    ChecksumType64 = $ChecksumType64
    UnzipLocation  = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Like "${PackageName}-*" | Select-Object -First 1).FullName
Rename-Item -Path $UnzipPath -NewName $PackageName

$BinFileName = Join-Path $InstallationPath "${PackageName}.exe"
Install-BinFile -Name "${PackageName}" -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
