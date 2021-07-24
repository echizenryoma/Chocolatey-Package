$ErrorActionPreference = 'Stop'

$PackageName = 'quiterss'
$Url32 = 'https://quiterss.org/files/0.19.4_/QuiteRSS-0.19.4.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

if (Test-Path $InstallationPath) {
    Get-ChildItem -Path $InstallationPath -exclude 'opt' | Remove-Item -Recurse -Force -ErrorAction Ignore
}

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$BinFile = Join-Path $UnzipPath "$PackageName.exe"
Install-BinFile -name ${PackageName} -path ${BinFile} -useStart
