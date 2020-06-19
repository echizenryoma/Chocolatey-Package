$ErrorActionPreference = 'Stop'

$PackageName = 'Calibre'
$Url = 'https://github.com/kovidgoyal/calibre/releases/download/v4.19.0/calibre-portable-installer-4.19.0.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'
$SilentArgs = "${UnzipLocation}"

$PackageArgs = @{
    PackageName = $PackageName
    Url         = $Url
    SilentArgs  = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match $PackageName | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$BinFile = (Get-ChildItem -Path $InstallationPath -Filter "*.exe" | Select-Object -First 1).FullName
Install-BinFile -Name $PackageName.ToLower() -Path $BinFile
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "${PackageName}.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFile -WorkingDirectory $InstallationPath
