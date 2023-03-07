$ErrorActionPreference = 'Stop'

$PackageName = 'BeyondCompare'
$Url64 = 'https://www.scootersoftware.com/BCompare-zh-4.4.6.27483.exe'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$TmpLocation = Join-Path $InstallationPath 'tmp'
$UnzipLocation = $TmpLocation

$DownloadFile = Join-Path $TmpLocation "${PackageName}.exe"
$PackageArgs = @{
    PackageName  = $PackageName
    Url64        = $Url64
    FileFullPath = $DownloadFile
}
Get-ChocolateyWebFile @PackageArgs

& innoextract.exe -e "$DownloadFile" -d "$UnzipLocation"

$BinName = "BCompare"
$AppPath = (Get-ChildItem -Path $UnzipLocation -Recurse -Include "${BinName}.exe").Directory.FullName
Copy-Item -Path $(Join-Path $AppPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $TmpLocation -Recurse -Force -ErrorAction Ignore

Install-BinFile -Path $(Join-Path $InstallationPath "${BinName}.exe") -Name "${BinName}"
