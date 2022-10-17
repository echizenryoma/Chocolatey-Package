$ErrorActionPreference = 'Stop'

function global:au_GetLatest {
    $base = 'https://jdk.java.net'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $url = $base + ($page.Links -match "JDK\s+\d+")[0].href

    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $url64 = ($page.Links.href -match "windows.*zip$")[0]
    $version = ($url64 -split '/|_' -match '^openjdk-\d+(\.\d+)*$')[0] -replace "openjdk-",""
    $dot_count = 2 - ($version.ToCharArray() | Where-Object { $_ -eq '.' } | Measure-Object).Count
    if ($dot_count -lt 0) {
        $dot_count = 0
    }
    $version = $version + (".0" * $dot_count)

    return @{
        Version = $version
        URL64   = $url64
    }
}

$PackageName = 'openjdk'
$Url64=$(global:au_GetLatest).URL64
$InstallationPath = Join-Path $(Get-ToolsLocation) 'java'

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs
