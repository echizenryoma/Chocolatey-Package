$ErrorActionPreference = 'Stop'

function global:au_GetLatest {
    $base = 'https://jdk.java.net'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $url = $base + ($page.Links -match "JDK\s+\d+")[0].href

    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $url64 = ($page.Links.href -match "windows.*zip$")[0]
    $version = ($url64 -split '/|_' -match '^openjdk-\d+(\.\d+)*$')[0] -replace "openjdk-", ""
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

$LatestInfo = $(global:au_GetLatest)

$PackageName = 'openjdk'
$Url64 = $LatestInfo.URL64
$Version = $LatestInfo.Version
$InstallationPath = Join-Path $(Get-ToolsLocation) 'java'
$TmpLocation = Join-Path $InstallationPath 'tmp'

$PackageArgs = @{
    PackageName   = $PackageName
    Url64         = $Url64
    UnzipLocation = $TmpLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipLocation = Get-ChildItem $TmpLocation -Directory | Select-Object -Last 1
$JdkLocation = Join-Path $InstallationPath $UnzipLocation.BaseName
Copy-Item -Path $UnzipLocation.FullName -Destination $JdkLocation -Recurse -Force
Remove-Item -Path $TmpLocation -Recurse -Force

$JdkLinkPath = Join-Path $InstallationPath 'jdk'
$JdkMajorLinkPath = Join-Path $InstallationPath "jdk$(([Version]$version).Major)"

New-Item -ItemType SymbolicLink -Path $JdkMajorLinkPath -Target $JdkLocation -Force
New-Item -ItemType SymbolicLink -Path $JdkLinkPath -Target $JdkMajorLinkPath -Force

$JAVA_HOME = $JdkLinkPath
Install-ChocolateyEnvironmentVariable -VariableName 'JAVA_HOME' -VariableValue $JAVA_HOME -VariableType 'Machine'
Install-ChocolateyPath -PathToInstall $(Join-Path $JAVA_HOME 'bin') -PathType 'Machine'
