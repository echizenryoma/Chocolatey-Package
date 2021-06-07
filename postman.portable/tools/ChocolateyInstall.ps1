$ErrorActionPreference = 'Stop'

$PackageName = 'postman'
$Url32 = 'https://dl.pstmn.io/download/8.6.1/Postman-win32-8.6.1-full.nupkg'
$Checksum32 = 'F7A25D42CF56B4DCAC95F9E37A173AADC995D707'
$ChecksumType32 = 'sha1'
$Url64 = 'https://dl.pstmn.io/download/8.6.1/Postman-win64-8.6.1-full.nupkg'
$Checksum64 = '0621A15E8DE7520CF3512CFC6396E947494A306D'
$ChecksumType64 = 'sha1'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

New-Item -ItemType Directory -Path $UnzipLocation -Force -ErrorAction Ignore

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

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory -Recurse | Where-Object Name -Match "net" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$BinFileName = (Get-ChildItem $InstallationPath -File | Where-Object Name -Match $PackageName | Select-Object -First 1).FullName
Install-BinFile -Name "${PackageName}" -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Postman.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
