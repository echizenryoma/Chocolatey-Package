$ErrorActionPreference = 'Stop'

$PackageName = 'FileZilla'
$Url32 = 'https://dl1.cdn.filezilla-project.org/client/FileZilla_3.39.0_win32.zip?h=qs94OxLzftLtGYMA-Ktlpw&x=1547297034'
$Checksum32 = 'bf76842249c0a471bf8db5bed0f6c135c2c953fbc8004a7035ab08a533189d618a5371365b46270ad69fde9f700b7f368b8ebfd96c6b2e37b0b4a3b5a7ad9504'
$ChecksumType32 = 'sha512'
$Url64 = 'https://dl1.cdn.filezilla-project.org/client/FileZilla_3.39.0_win64.zip?h=hDpIU_umhHDozX3F29wp6w&x=1547297034'
$Checksum64 = '7a5392700dd6538c573ba267eeb2bab755e9d72f45e50c29794714da5651f055b9664d0a8f3508ff7b15e128c96c341c33e1740960eff6199fd619cee65e93e4'
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
