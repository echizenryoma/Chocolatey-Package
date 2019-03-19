$ErrorActionPreference = 'Stop'

$PackageName = 'FileZilla'
$Page = Invoke-WebRequest -UseBasicParsing -Uri 'https://filezilla-project.org/download.php?show_all=1'
$Url32 = $page.Links.href -match "win32\.zip" | Select-Object -First 1
$Checksum32 = '72d1adf580a5ab498cb928e5487accc249882fba03b05b47948b81cb0fdb87f7e603fb0366f1c052fadecaee3467f32d7cf649d0c599a3e94d3f900206005498'
$ChecksumType32 = 'sha512'
$Url64 = $page.Links.href -match "win64\.zip" | Select-Object -First 1
$Checksum64 = '63ad44c14fe501777fe577b449d8e05f9c9ab05aff4aa26acf99e90074dc814c210d5de801fb796ce2b41be2e3963e57d2572d139bd5a96a8635fbc6bb0c5488'
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
