$ErrorActionPreference = 'Stop'

$PackageName = 'FileZilla'
$Page = Invoke-WebRequest -UseBasicParsing -Uri 'https://filezilla-project.org/download.php?show_all=1'
$Url32 = $page.Links.href -match "win32\.zip" | Select-Object -First 1
$Checksum32 = '0a30d8ff23d85bf30774acf0f0a9a82b51769a9363c20aad8290e0d1660ae97f7be94314edaa88b57f8569876e228d9ae17578e9332551de0837252d0724927f'
$ChecksumType32 = 'sha512'
$Url64 = $page.Links.href -match "win64\.zip" | Select-Object -First 1
$Checksum64 = 'bee178867b7d882225cb78a6225891e883cb85e3f46ff8df896b9fe8eabca304961338e59a375443edcc752bad6051739829df512732ca0fdfd22a364366a2e9'
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
