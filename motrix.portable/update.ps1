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
    $base = "${domain}/agalwood/Motrix"

    $url = "${base}/releases/latest"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $version = ($page.Links.href -match "releases/tag/(v?)\d+(\.\d+)+$" | Select-Object -Unique -First 1) -split "/|v" -match "\d+(\.\d+)+" | Select-Object -First 1
    $url = $domain + ($page.Links.href -match "win\.zip$" | Select-Object -First 1)

    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
