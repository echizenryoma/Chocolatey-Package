$ErrorActionPreference = 'Stop'

$PackageName = 'inno-setup'
$Url32 = 'https://github.com/jrsoftware/ispack/archive/is-6_0_1.zip'
$UrlExtra = 'http://www.jrsoftware.org/download.php/ip015.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Get-ToolsLocation

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$null = New-Item -ItemType Directory -Force -Path $InstallationPath -ErrorAction Ignore
$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "$([IO.Path]::GetFileNameWithoutExtension($Url32))" | Select-Object -First 1).FullName

Copy-Item -Path $(Join-Path $UnzipPath 'isfiles\*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $UrlExtra
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @packageArgs

Install-BinFile -Path $(Join-Path $InstallationPath 'ISCC.exe') -Name 'ISCC'
