$ErrorActionPreference = 'Stop'

$PackageName = 'sandboxie'
$Url32 = 'https://www.sandboxie.com/attic/SandboxieInstall-522.exe'
$Checksum32 = 'f3dfb2f5629d3e1d8e8a77abacf5d428c9a7495b'
$ChecksumType32 = 'SHA1'

$PackageArgs = @{
    PackageName  = $PackageName
    Url          = $Url32
    Checksum     = $Checksum32
    ChecksumType = $ChecksumType32
    SilentArgs   = '/lang=2052 /install /S'
}
Install-ChocolateyPackage @PackageArgs

Remove-Item -Force -Recurse "Registry::HKEY_CLASSES_ROOT\CLSID\{98E6BD24-2D93-41A5-BC6D-CB7C1507318B}" -ErrorAction Ignore
