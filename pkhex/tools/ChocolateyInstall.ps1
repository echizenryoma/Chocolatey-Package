$ErrorActionPreference = 'Stop'

$PackageName = 'pkhex'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$page = Invoke-WebRequest -UseBasicParsing -Uri "https://projectpokemon.org/forums/files/file/1-pkhex/" -SessionVariable session
$url = [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CMatch "Download\s+this\s+file" | Select-Object -ExpandProperty href))

$page = Invoke-WebRequest -UseBasicParsing -Uri $url -WebSession $session
$url = [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CLike "*confirm*Download*" | Select-Object -First 1 -ExpandProperty href))
$cookie = $session.Cookies.GetCookies("https://projectpokemon.org")

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $url
    UnzipLocation = $ToolsPath
    Options       = @{
        Headers = @{
            UserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36' 
            Cookie    = '{0}={1}' -f $cookie.Name, $cookie.Value
            Referer   = 'https://projectpokemon.org'
        }
    }
}
Install-ChocolateyZipPackage @PackageArgs
