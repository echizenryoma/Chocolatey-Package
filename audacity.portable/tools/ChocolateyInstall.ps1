$ErrorActionPreference = 'Stop'

$base = 'https://api.fosshub.com'

function GetLatestUrl ([string]$arch) {
    $url = 'https://www.fosshub.com/Audacity.html'
    $page = Invoke-WebRequest -Uri $url -UseBasicParsing
    $obj = ($page.Content -split '<|>' -match "settings") -split "=" -match "{" | ConvertFrom-Json
    $body = @{
        "projectId"  = $obj.projectId
        "releaseId"  = ($obj.pool.f.r | Select-Object -Unique -First 1)
        "projectUri" = $obj.pool.u
        "fileName"   = ($obj.pool.f.n -match "zip" -notmatch "manual" -match "${arch}bit")[0]
        "source"     = $obj.pool.c
    } | ConvertTo-Json -Compress

    $url = "${base}/download/"
    $page = Invoke-WebRequest -Method Post -Body $body -ContentType "application/json" -Uri $url
    $obj = $page.Content | ConvertFrom-Json
    return $obj.data.url
}

$PackageName = 'audacity'
$Checksum = 'a350e772e000b9c20ed25b0ef080aed1f6702b7255e3911e6e366b8566e94fff'
$ChecksumType = 'sha256'
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName
$UnzipLocation = Join-Path $InstallationPath 'tmp'

$Url32 = GetLatestUrl("32")
$Url64 = GetLatestUrl("64")

$PackageArgs = @{
    PackageName   = $PackageName
    Url32         = $Url32
    Url64         = $Url64
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $UnzipLocation
    Options       = @{
        Headers = @{
            UserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36' 
            Referer   = 'https://www.fosshub.com/Audacity.html'
        }
    }
}
Install-ChocolateyZipPackage @PackageArgs

$UnzipPath = (Get-ChildItem $UnzipLocation -Directory | Where-Object Name -Match "${PackageName}" | Select-Object -First 1).FullName
Copy-Item -Path $(Join-Path $UnzipPath '*') -Destination $InstallationPath -Recurse -Force
Remove-Item -Path $UnzipLocation -Recurse -Force -ErrorAction Ignore

$BinFile = Get-Item $(Join-Path $InstallationPath "${PackageName}.exe")
Install-BinFile -Path $BinFile -Name "${PackageName}"
