Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = 'https://quiterss.org'
    $page = Invoke-WebRequest -Uri "$base/en/download" -UseBasicParsing
    $url = $base + ($page.links | Where-Object href -match '.zip$')[0].href
    $version = $url -split '-|(.zip)' -match '^\d+(\.\d+)+$'

    return @{
        URL32   = $url
        Version = $version
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
