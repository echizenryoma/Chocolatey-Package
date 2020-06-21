$ErrorActionPreference = 'Stop'

function GetUrl {
    $base = "https://www.foobar2000.org"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/download"

    $url = $base + ($page.Links.href -match "\.exe$" | Select-Object -Unique -First 1)
    $version = $url -split "v|_|\.exe" -match "\d+(\.\d+)+" | Select-Object -Unique -Last 1
	
    return $url.Replace("/getfile/", "/files/")
}

$PackageName = 'foobar2000'
$Url = GetUrl
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    UnzipLocation = $UnzipLocation
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-Item $UnzipLocation).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

Remove-Item -Path $(Join-Path $InstallationPath '$PLUGINSDIR') -Recurse -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $InstallationPath '$R0') -Force -ErrorAction Ignore
Move-Item -Path $(Join-Path $InstallationPath 'foobar2000 Shell Associations Updater.exe') -Destination $(Join-Path $InstallationPath 'Shell Associations Updater.exe') -Force -ErrorAction Ignore


