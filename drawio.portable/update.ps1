Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $domain = "https://github.com"
    $base = "${domain}/jgraph/drawio-desktop"

    $url = "${base}/releases/latest"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $version = ($page.Links.href -match "releases/tag/(v?)\d+(\.\d+)+$" | Select-Object -Unique -First 1) -split "/|v" -match "\d+(\.\d+)+" | Select-Object -First 1
    $url64 = $domain + ($page.Links.href -match "^/.*windows-no-installer" | Select-Object -First 1)
	
    return @{
        Version = $version
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
