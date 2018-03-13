$ErrorActionPreference = 'Stop'

$PackageName = 'sandboxie'
$Url32 = 'https://www.sandboxie.com/attic/SandboxieInstall-524.exe'
$Checksum32 = 'a3376224dc5c5aa991d5f6c7855b5ce968939f33'
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
