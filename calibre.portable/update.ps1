Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $domain = "https://github.com"
    $base = "${domain}/kovidgoyal/calibre"

    $url = "${base}/releases/latest"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $version = ($page.Links.href -match "releases/tag/(v?)\d+(\.\d+)+$" | Select-Object -Unique -First 1) -split "/|v" -match "\d+(\.\d+)+" | Select-Object -First 1

    $url32 = $domain + ($page.Links | Where-Object outerHTML -Match "Calibre Portable" | Select-Object -First 1 -ExpandProperty href)
	
    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
