$ErrorActionPreference = 'Stop'

$PackageName = 'FileZilla'
$Page = Invoke-WebRequest -UseBasicParsing -Uri 'https://filezilla-project.org/download.php?show_all=1'
$Url32 = $page.Links.href -match "win32\.zip" | Select-Object -First 1
$Checksum32 = '324d9e9fdc6289652f80c9d001348576dde9af8c0a1169d0aaa454dd2078c9795c9baee3676743a96e239099ff982fd6ddbfa880a20b4f1f2a55078ec212697f'
$ChecksumType32 = 'sha512'
$Url64 = $page.Links.href -match "win64\.zip" | Select-Object -First 1
$Checksum64 = '86fb928d39a947a7d06853be94de0ecf5cabc888c1f0216859912cca9d615b97c8eb8c7574d1acdabcda82b80d3cbf76cc79497ea864184ca9e891d1df960eaa'
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
