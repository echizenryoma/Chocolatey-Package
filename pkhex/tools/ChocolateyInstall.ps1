﻿$ErrorActionPreference = 'Stop'

$PackageName = 'pkhex'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$base = 'https://projectpokemon.org'
$url = "${base}/forums/files/file/1-pkhex/"
$page = Invoke-WebRequest -UseBasicParsing -Uri $url -SessionVariable session
$url = [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CMatch "Download\s+this\s+file" | Select-Object -ExpandProperty href))

$page = Invoke-WebRequest -UseBasicParsing -Uri $url -WebSession $session
$url = [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CLike "*confirm*Download*" | Select-Object -First 1 -ExpandProperty href))
$cookies = $session.Cookies.GetCookies($base)
$cookie = ""
foreach ($it in $cookies) {
    $cookie = $cookie + ('{0}={1};' -f $it.Name, $it.Value)
}


$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $url
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
