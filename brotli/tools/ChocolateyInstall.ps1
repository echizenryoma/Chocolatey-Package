$ErrorActionPreference = 'Stop'

$PackageName = 'brotli'
$Url = 'https://github.com/google/brotli/releases/download/v1.0.4/brotli-v1.0.4-win_i686.zip'
$Url64 = 'https://github.com/google/brotli/releases/download/v1.0.4/brotli_dll-v1.0.4-win_x86_64.zip'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Url64         = $Url64
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
