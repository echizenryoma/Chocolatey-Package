$ErrorActionPreference = 'Stop'

$PackageName = 'pkhex'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$FilePath = Join-Path $ToolsPath 'PKHex.zip'

$page = Invoke-WebRequest -UseBasicParsing -Uri "https://projectpokemon.org/forums/files/file/1-pkhex/" -SessionVariable session
$url =  [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CMatch "Download\s+this\s+file" | Select-Object -ExpandProperty href))
	
$page = Invoke-WebRequest -UseBasicParsing -Uri $url -WebSession $session
$url =  [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CLike "*confirm*Download*" | Select-Object -First 1 -ExpandProperty href))

Invoke-WebRequest -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36' -WebSession $session -Uri $url -OutFile $FilePath

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $FilePath
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
