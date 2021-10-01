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
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $version = (($page.Links.outerHTML -match "7-Zip\s+\d+(\.\d+)+" -notmatch "(beta)|(alpha)")[0] -split "\s|<|>" -match "\d+(\.\d+)+")[0]
    
    $url32 = $base + ($page.Links.href -match "7z$($version -replace '\.','')\.exe$")[0]
    $url64 = $base + ($page.Links.href -match "7z$($version -replace '\.','')(\-x64)\.exe$")[0]
    $url_extra = $base + ($page.Links.href -match "7z$($version -replace '\.','')\-extra\.7z")[0]

    return @{
        Version   = $version
        URL32     = $url32
        URL64     = $url64
        URL_Extra = $url_extra
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
