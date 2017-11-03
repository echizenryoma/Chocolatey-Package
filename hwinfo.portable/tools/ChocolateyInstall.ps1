$ErrorActionPreference = 'Stop'

$PackageName = 'hwinfo.portable'
$Url32 = 'https://www.hwinfo.com/files/hw32_560.zip'
$Url64 = 'https://www.hwinfo.com/files/hw64_560.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

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
