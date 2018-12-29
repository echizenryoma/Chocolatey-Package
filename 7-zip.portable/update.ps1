Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"    = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')"    = "`$1'$($Latest.URL64)'"
            "(^[$]UrlExtra\s*=\s*)('.*')" = "`$1'$($Latest.URL_Extra)'"
        }
    }
}

function global:au_GetLatest {
    $base = 'https://www.7-zip.org/'
    
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/download.html"
    $version = (($page.Links.href -match "7z\d+" | Select-Object -First 1) -split "7z|\." -match "\d+" | Select-Object -First 1).Insert(2, ".")
    
    $url32 = $base + ($page.Links.href -match "7z$($version -replace '\.','')\.exe$" | Select-Object -First 1)
    $url64 = $base + ($page.Links.href -match "7z$($version -replace '\.','')(\-x64)\.exe$" | Select-Object -First 1)
    $url_extra = $base + ($page.Links.href -match "7z$($version -replace '\.','')\-extra\.7z" | Select-Object -First 1)
       
    return @{
        Version   = $version
        URL32     = $url32
        URL64     = $url64
        URL_Extra = $url_extra
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
