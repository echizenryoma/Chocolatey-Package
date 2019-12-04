$ErrorActionPreference = 'Stop'

$PackageName = 'XDown'
$Url32 = 'https://dl.xdown.org/xdown-1.0.1.7.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName.ToLower()
$UnzipLocation = Join-Path $InstallationPath 'tmp'

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$BinFileName = Join-Path $InstallationPath "${PackageName}.exe"
Install-BinFile -Name "${PackageName}" -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath

