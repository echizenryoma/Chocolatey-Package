$ErrorActionPreference = 'Stop'

$PackageName = 'openssl'
$Url =  'https://www.npcglib.org/~stathis/downloads/openssl-1.1.0f-vs2017.7z'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$PackageArgs = @{
    PackageName   = $PackageName
    url           = $url
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs

if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $True) {
    Get-ChildItem $ToolsPath -Directory -Include "bin" -Recurse | 
    Get-ChildItem -File -Filter "*.exe" -Recurse | 
    ForEach-Object { 
        New-Item "$($_.FullName).ignore" -Type File -Force | Out-Null 
    }
} else {
    Get-ChildItem $ToolsPath -Directory -Include "bin64" -Recurse | 
    Get-ChildItem -File -Filter "*.exe" -Recurse | 
    ForEach-Object { 
        New-Item "$($_.FullName).ignore" -Type File -Force | Out-Null 
    }
}
