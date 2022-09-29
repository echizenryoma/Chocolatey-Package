import-module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://www.antlr.org"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/download.html"
    $url = "${base}/" + ($page.Links.href -match 'complete.jar$' | Sort-Object -Unique)
    $version = $url -split '-' -match '\d+(\.\d)*'

    return @{
        Version = $version
        URL     = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
