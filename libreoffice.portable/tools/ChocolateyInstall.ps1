$ErrorActionPreference = 'Stop'

$PackageName = 'LibreOffice'
$Url64 = 'https://download.documentfoundation.org/libreoffice/portable/7.3.5/LibreOfficePortable_7.3.5_MultilingualAll.paf.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Recurse -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $InstallationPath '[NSIS].nsi') -Recurse -Force -ErrorAction Ignore
