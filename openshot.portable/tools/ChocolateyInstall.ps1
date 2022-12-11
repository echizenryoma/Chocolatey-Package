$ErrorActionPreference = 'Stop'

$PackageName = 'OpenShot'
$Url32 = 'https://github.com/OpenShot/openshot-qt/releases/download/v3.0.0/OpenShot-v3.0.0-x86.exe'
$Url64 = 'https://github.com/OpenShot/openshot-qt/releases/download/v3.0.0/OpenShot-v3.0.0-x86_64.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$TmpLocation = Join-Path $InstallationPath 'tmp'
$UnzipLocation = $TmpLocation

$DownloadFile = Join-Path $TmpLocation "${PackageName}.exe"
$PackageArgs = @{
    PackageName  = $PackageName
    Url32        = $Url32
    Url64        = $Url64
    FileFullPath = $DownloadFile
}
Get-ChocolateyWebFile @PackageArgs

& innoextract.exe -e "$DownloadFile" -d "$UnzipLocation"

$BinName = "openshot-qt"
$AppPath = (Get-ChildItem -Path $UnzipLocation -Recurse -Include "${BinName}.exe").Directory.FullName
Copy-Item -Path $(Join-Path $AppPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $TmpLocation -Recurse -Force -ErrorAction Ignore

Install-BinFile -Path $(Join-Path $InstallationPath "${BinName}.exe") -Name "${BinName}"
