$ErrorActionPreference = 'Stop'

$PackageName = 'audacity'
$Checksum = 'b697958c49de95818f7322bca7a043cee1580c3ecab91d62bfb649457edd285a'
$ChecksumType = 'sha256'
$ToolsPath = Split-Path $MyInvocation.MyCommand.Definition

$url = 'https://www.fosshub.com/Audacity.html'
$page = Invoke-WebRequest -Uri $url
$obj = ($page.Scripts.outerText -match "settings") -split "=" -match "{" | ConvertFrom-Json
$body = @{
    "projectId"  = $obj.projectId
    "releaseId"  = ($obj.pool.f.r | Select-Object -Unique -First 1)
    "projectUri" = $obj.pool.u
    "fileName"   = ($obj.pool.f.n -match "zip" -notmatch "manual")[0]
    "source"     = $obj.pool.c
} | ConvertTo-Json -Compress

$base = 'https://api.fosshub.com'
$url = "${base}/download/"
$page = Invoke-WebRequest -Method Options -Uri $url -SessionVariable session
$page = Invoke-WebRequest -Method Post -Body $body -ContentType "application/json" -Uri $url -WebSession $session
$obj = $page.Content | ConvertFrom-Json
$Url = $obj.data.url

$cookies = $session.Cookies.GetCookies($base)
$cookie = ""
foreach ($it in $cookies) {
    $cookie = $cookie + ('{0}={1};' -f $it.Name, $it.Value)
}

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $Url
    Checksum      = $Checksum
    ChecksumType  = $ChecksumType
    UnzipLocation = $ToolsPath
    Options       = @{
        Headers = @{
            UserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36' 
            Cookie    = $cookie
            Referer   = $url
        }
    }
}
Install-ChocolateyZipPackage @PackageArgs
