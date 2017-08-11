$ErrorActionPreference = 'Stop'

$PackageName = 'pkhex'
$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$FilePath = Join-Path $ToolsPath 'PKHex.zip'

$page = Invoke-WebRequest -UseBasicParsing -Uri "https://projectpokemon.org/forums/files/file/1-pkhex/" -SessionVariable session
$url =  [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CMatch "Download\s+this\s+file" | Select-Object -ExpandProperty href))
	
$page = Invoke-WebRequest -UseBasicParsing -Uri $url -WebSession $session
$url =  [System.Net.WebUtility]::HtmlDecode(($page.Links | Where-Object outerHTML -CLike "*confirm*Download*" | Select-Object -First 1 -ExpandProperty href))

Invoke-WebRequest -WebSession $session -Uri $url -OutFile $filePath

$PackageArgs = @{
    PackageName   = $PackageName
    Url           = $FilePath
    UnzipLocation = $ToolsPath
}
Install-ChocolateyZipPackage @PackageArgs
