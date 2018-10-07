Import-Module AU
Add-Type -AssemblyName System.Web

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]UrlExtra\s*=\s*)('.*')" = "`$1'$($Latest.URL_Extra)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://ugetdm.com/go/windows-download"
    $url =  [System.Uri]([System.Web.HttpUtility]::HtmlDecode(($page.Links | Where-Object id -Match 'btn-problems-downloading' | Select-Object -First 1 -ExpandProperty 'data-release-url')))
    $url =  "$($url.Scheme)://$($url.Host)$($url.AbsolutePath)"
    $version = $url -split "/|-" -match "^\d+(\.\d+)+$" | Select-Object -Unique -First 1

    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://ugetdm.com/go/windows-locale-download"
    $url_extra = [System.Uri]([System.Web.HttpUtility]::HtmlDecode(($page.Links | Where-Object id -Match 'btn-problems-downloading' | Select-Object -First 1 -ExpandProperty 'data-release-url')))
    $url_extra =  "$($url_extra.Scheme)://$($url_extra.Host)$($url_extra.AbsolutePath)"
	
    return @{
        Version   = $version
        URL       = $url
        URL_Extra = $url_extra
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
