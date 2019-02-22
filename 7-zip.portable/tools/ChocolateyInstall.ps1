$ErrorActionPreference = 'Stop'

$PackageName = '7-zip'
$Url32 = 'https://www.7-zip.org/a/7z1900.exe'
$Url64 = 'https://www.7-zip.org/a/7z1900-x64.exe'
$UrlExtra = 'https://www.7-zip.org/a/7z1900-extra.7z'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $UrlExtra
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$BinPath = Join-Path $InstallationPath "7z.exe"
Install-BinFile -Path $BinPath -Name $([IO.Path]::GetFileName($BinPath))

$SystemStartMenuPath = [IO.Path]::Combine($([Environment]::GetFolderPath('CommonApplicationData')), "Microsoft", "Windows", "Start Menu", "Programs")
$BinPath = Join-Path $InstallationPath "7zFM.exe"
$LinkPath = Join-Path $SystemStartMenuPath "7-Zip File Manager.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinPath -WorkingDirectory $InstallationPath
