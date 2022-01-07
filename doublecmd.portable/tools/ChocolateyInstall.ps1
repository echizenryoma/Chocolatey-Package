$ErrorActionPreference = 'Stop'

$PackageName = 'doublecmd'
$Url32 = 'https://github.com/doublecmd/doublecmd/releases/download/v1.0.3/doublecmd-1.0.3.i386-win32.zip'
$Url64 = 'https://github.com/doublecmd/doublecmd/releases/download/v1.0.3/doublecmd-1.0.3.x86_64-win64.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

if (Test-Path $InstallationPath) {
    Get-ChildItem -Path $InstallationPath -exclude 'opt' | Remove-Item -Recurse -Force -ErrorAction Ignore
}

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$BinPath = Join-Path $InstallationPath "${PackageName}.exe"
Install-BinFile -Path $BinPath -Name $([IO.Path]::GetFileNameWithoutExtension($BinPath))
