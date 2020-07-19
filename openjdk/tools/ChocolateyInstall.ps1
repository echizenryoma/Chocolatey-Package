$ErrorActionPreference = 'Stop'

function global:au_GetLatest {
    $base = 'https://jdk.java.net'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $url = $base + ($page.Links -match "JDK\s+\d+")[0].href

    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $url64 = ($page.Links.href -match "windows.*zip$")[0]
    $version = ($url64 -split '/|_|-' -match '^\d+(\.\d+)+$')[0]

    return @{
        Version = $version
        URL64   = $url64
    }
}

$PackageName = 'openjdk'
$Url64=$(global:au_GetLatest).URL64
$InstallationPath = Get-ToolsLocation

$JdkVersion = ($Url64 -split "/|_" -match "openjdk-\d+(\.\d+)+")[0] -replace "openjdk", "jdk"
$UnzipLocation = Join-Path $(Get-ToolsLocation) $JdkVersion
if (Test-Path $UnzipLocation) {
    Remove-Item -Path $UnzipLocation -Force -Recurse
}

$PackageArgs = @{
    PackageName    = $PackageName
    Url64          = $Url64
    UnzipLocation  = $InstallationPath
}
Install-ChocolateyZipPackage @PackageArgs

$JAVA_HOME = $UnzipLocation
Install-ChocolateyEnvironmentVariable -VariableName 'JAVA_HOME' -VariableValue $JAVA_HOME -VariableType 'Machine'

Install-ChocolateyPath -PathToInstall $(Join-Path $JAVA_HOME 'bin') -PathType 'Machine'
