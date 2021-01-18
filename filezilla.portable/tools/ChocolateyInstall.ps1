$ErrorActionPreference = 'Stop'

$PackageName = 'FileZilla'
$Page = Invoke-WebRequest -UseBasicParsing -Uri 'https://filezilla-project.org/download.php?show_all=1'
$Url32 = $page.Links.href -match "win32\.zip" | Select-Object -First 1
$Checksum32 = 'b913e6bac0930b1b787ba7aca8217e3b6f6508d54823af5d4bb94ad77191b4f2ff216717fffc5215266d66760b5f8843345cf135e411b3c24801a1a6339e24a0'
$ChecksumType32 = 'sha512'
$Url64 = $page.Links.href -match "win64\.zip" | Select-Object -First 1
$Checksum64 = '77c42ba4fc3c4a21cb981067a70308986e6b064ce43f3bc29fcd0cd040bdfc8d95833188c52008bc0c90e6a1c44fe2343b558eff4bb66ce1a5210ae2b8b3e0e5'
$ChecksumType64 = 'sha512'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

Remove-Item -Path $InstallationPath -Recurse -Force -ErrorAction Ignore

$UnzipLocation = Join-Path $InstallationPath 'tmp'
New-Item -ItemType Directory -Path $UnzipLocation -Force -ErrorAction Ignore | Out-Null
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

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$BinFileName = Join-Path $InstallationPath "${PackageName}.exe"
Install-BinFile -Name "${PackageName}" -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
