$ErrorActionPreference = 'Stop'

$PackageName = 'uget'
$Url = 'https://downloads.sourceforge.net/project/urlget/uget%20%28stable%29/2.2.1/uget-2.2.1-win32%2Bgtk3.7z'
$UrlExtra = 'https://downloads.sourceforge.net/project/urlget/uget%20%28stable%29/2.2.1/uget-2.2.1-win32-locale.7z'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $UrlExtra
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$BinFileName = [IO.Path]::Combine($InstallationPath, 'bin', "${PackageName}.exe")
Install-BinFile -Name ${PackageName} -Path $BinFileName
$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "uGet.lnk"
Install-ChocolateyShortcut -ShortcutFilePath $LinkPath -TargetPath $BinFileName -WorkingDirectory $InstallationPath
