$ErrorActionPreference = 'Stop'

$PackageName = 'ruby'
$Url32 = 'https://github.com/oneclick/rubyinstaller2/releases/download/rubyinstaller-2.5.1-1/rubyinstaller-2.5.1-1-x86.7z'
$Url64 = 'https://github.com/oneclick/rubyinstaller2/releases/download/rubyinstaller-2.5.1-1/rubyinstaller-2.5.1-1-x64.7z'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Get-ToolsLocation

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    Url64          = $Url64
    UnzipLocation  = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$null = New-Item -ItemType Directory -Force -Path $InstallationPath -ErrorAction Ignore
$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Like "${PackageName}installer-*x*" | Select-Object -First 1).FullName

$null = Copy-Item -Path $(Join-Path $UnzipPath "*")  -Destination $InstallationPath -Recurse
$null = Remove-Item -Path $UnzipPath -Recurse -Force -ErrorAction Ignore

$Bin = Join-Path $InstallationPath 'bin'
Install-ChocolateyPath -PathToInstall $Bin -PathType 'Machine'
