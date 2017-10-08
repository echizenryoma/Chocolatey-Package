$ErrorActionPreference = 'Stop'

$PackageName = 'hwinfo.portable'
$Url32 = 'https://www.hwinfo.com/files/hw32_558.zip'
$Url64 = 'https://www.hwinfo.com/files/hw64_558.zip'
$ToolsPath = Join-Path $(Get-ToolsLocation) $PackageName

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url32
    Url64         = $Url64
    UnzipLocation = $ToolsPath
    Options       = @{
        Headers = @{
            Referer = 'https://www.hwinfo.com/download.php'
        }
    }
}
Install-ChocolateyZipPackage @PackageArgs
