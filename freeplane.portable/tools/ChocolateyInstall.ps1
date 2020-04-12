$ErrorActionPreference = 'Stop'

$PackageName = 'freeplane'
$Url32 = 'https://sourceforge.net/projects/freeplane/files/freeplane%20stable/freeplane_bin-1.8.2.zip'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

New-Item -ItemType Directory -Path "$UnzipLocation" -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Checksum      = $Checksum32
    ChecksumType  = $ChecksumType32
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match $PackageName | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath "*") -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore
