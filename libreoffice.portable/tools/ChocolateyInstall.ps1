$ErrorActionPreference = 'Stop'

$PackageName = 'LibreOffice'
$Url64 = 'https://download.documentfoundation.org/libreoffice/portable/7.4.3/LibreOfficePortable_7.4.3_MultilingualAll.paf.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Recurse -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $InstallationPath '[NSIS].nsi') -Recurse -Force -ErrorAction Ignore
