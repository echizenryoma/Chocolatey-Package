$ErrorActionPreference = 'Stop'

$PackageName = 'tesseract'
$Url = 'https://digi.bib.uni-mannheim.de/tesseract/tesseract-ocr-setup-3.05.01-20170602.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
Install-ChocolateyEnvironmentVariable -VariableName 'TESSDATA_PREFIX' -VariableValue $(Join-Path $InstallationPath 'tessdata') -VariableType 'Machine'
Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Recurse -Force