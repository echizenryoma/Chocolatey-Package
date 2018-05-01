$ErrorActionPreference = 'Stop'

$PackageName = 'qemu'
$Url32 = 'https://qemu.weilnetz.de/w32/qemu-w32-setup-20180430.exe'
$Checksum32 = '32e6af199d36b10dee08ccc896411858c559f5170c7cf1cbfd5889d6010144121671792ff19645b46906efbdefc86e78d1385585e444e7586d99f6ebb67fc291'
$ChecksumType32 = 'sha512'
$Url64 = 'https://qemu.weilnetz.de/w64/qemu-w64-setup-20180430.exe'
$Checksum64 = '58df872f50ea68ab1c6c2d791ac87750f2fd084a7c73e4be39c612e48dad9585f32b0a8657d0df1fb66dc48c8f6886978e5457cba1bd441ee07829c7cbbd885f'
$ChecksumType64 = 'sha512'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName    = $PackageName
    Url            = $Url32
    ChecksumType   = $ChecksumType32
    Checksum       = $Checksum32
    Url64          = $Url64
    ChecksumType64 = $ChecksumType64
    Checksum64     = $Checksum64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Force -Recurse -ErrorAction Ignore

Install-ChocolateyPath -PathToInstall $InstallationPath -PathType 'Machine'
