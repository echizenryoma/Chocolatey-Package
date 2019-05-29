$ErrorActionPreference = 'Stop'

$PackageName = 'inno-setup'
$Url32 = 'https://github.com/jrsoftware/ispack/archive/is-6_0_2.zip'
$UrlExtra = 'http://www.jrsoftware.org/download.php/ip015.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
Remove-Item -Path $InstallationPath -Recurse -Force -ErrorAction Ignore

$UnzipLocation = Join-Path $InstallationPath 'tmp'
New-Item -ItemType Directory -Path $UnzipLocation -Force -ErrorAction Ignore | Out-Null
$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory -Depth 2 -Recurse | Where-Object Name -Match "isfiles" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $UrlExtra
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @packageArgs

Install-BinFile -Path $(Join-Path $InstallationPath 'ISCC.exe') -Name 'ISCC'
