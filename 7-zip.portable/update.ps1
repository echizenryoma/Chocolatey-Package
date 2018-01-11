Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"    = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')"    = "`$1'$($Latest.URL64)'"
            "(^[$]UrlExtra\s*=\s*)('.*')" = "`$1'$($Latest.URL_EXTRA)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'http://www.7-zip.org/download.html'
    $version = (($page.Links | Where-Object href -Match "7z\d+" | Select-Object -First 1 -ExpandProperty href) -split "7z|\." -match "\d+" | Select-Object -First 1).Insert(2, ".")
    
    $url32 = $page.links | Where-Object href -match "7z$($version -replace '\.','')\.exe$" | Select-Object -First 1 -ExpandProperty href
    $url64 = $page.links | Where-Object href -match "7z$($version -replace '\.','')(\-x64)\.exe$" | Select-Object -First 1 -ExpandProperty href
    $url_extra = $page.links | Where-Object href -match "7z$($version -replace '\.','')\-extra\.7z" | Select-Object -First 1 -ExpandProperty href
       
    return @{
        Version  = $version
        URL32    = 'http://www.7-zip.org/' + $url32
        URL64    = 'http://www.7-zip.org/' + $url64
        URL_EXTRA = 'http://www.7-zip.org/' + $url_extra
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
