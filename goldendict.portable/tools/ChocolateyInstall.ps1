$ErrorActionPreference = 'Stop'

$PackageName = 'GoldenDict'
$Url64 = 'https://github.com/xiaoyifang/goldendict/releases/download/v22.12.22-WinterSolstice.221220.311d08c6/5.15.2-GoldenDict.exe_windows-2019_20221220.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

if (Test-Path $InstallationPath) {
    Get-ChildItem -Path $InstallationPath -Exclude "content", "portable" -ErrorAction Ignore | Remove-Item -Recurse -Force -ErrorAction Ignore
}

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore
