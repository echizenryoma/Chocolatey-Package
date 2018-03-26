Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')"    = "`$1'$($Latest.URL32)'"
            "(^[$]UrlExtra\s*=\s*)('.*')" = "`$1'$($Latest.UrlExtra)'"
        }
    }
}

function global:au_GetLatest {
    $base = 'https://github.com'
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/jrsoftware/ispack/releases"
    $url32 = $base + ($page.Links.href -match "is-\d+(_\d+)+\.zip" | Select-Object -First 1)
    $version = [IO.Path]::GetFileNameWithoutExtension($url32) -split "-" -replace "_", "." -match "\d+(\.\d+)+" | Select-Object -First 1

    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://other.jrsoftware.org/ip/"
    $url_extra = ($page.Links.href -match ".zip" | Select-Object -First 1)

    return @{
        Version  = $version
        URL32    = $url32
        UrlExtra = $url_extra
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
