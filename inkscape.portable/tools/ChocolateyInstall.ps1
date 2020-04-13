$ErrorActionPreference = 'Stop'

$PackageName = 'InkScape'
$Url32 = 'https://inkscape.org/gallery/item/18063/inkscape-0.92.5-x86.7z'
$Checksum32 = '039f85ca89c791f2a05a0e24c67c9fb3'
$ChecksumType32 = 'md5'
$Url64 = 'https://inkscape.org/gallery/item/18064/inkscape-0.92.5-x64.7z'
$Checksum64 = '9b737dd5648ac7b3094828b8f3511283'
$ChecksumType64 = 'md5'
$InstallationPath = Join-Path $(Get-ToolsLocation) $($PackageName.ToLower())
$UnzipLocation = Join-Path $InstallationPath 'tmp'

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
Install-ChocolateyZipPackage @packageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$BinFileName = Join-Path $InstallationPath "$($PackageName.ToLower()).exe"
Install-BinFile -Name $($PackageName.ToLower()) -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
