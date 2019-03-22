$ErrorActionPreference = 'Stop'

$PackageName = 'GoldenDict'
$Url32 = 'https://sourceforge.net/projects/goldendict/files/early%20access%20builds/Qt5-based/GoldenDict-1.5.0-RC2-359-g9bae6d2_%28QT_5121%29.7z/download'
$Url64 = 'https://sourceforge.net/projects/goldendict/files/early%20access%20builds/Qt5-based/64bit/GoldenDict-1.5.0-RC2-359-g9bae6d2_%28QT_5121%29%2864bit%29.7z/download'
$InstallationPath = Get-ToolsLocation

Get-ChildItem -Path $InstallationPath -Exclude "content", "portable" -ErrorAction Ignore | Remove-Item -Recurse -Force -ErrorAction Ignore

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
