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
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'http://www.jrsoftware.org/'
    $version = ($page.Links -match "\d+(\.\d+)+" | Select-Object -First 1).outerHTML -split '\s|<|>' -match '\d+(\.\d+)+' | Select-Object -First 1
    $url32 = 'http://www.jrsoftware.org/download.php/is-unicode.exe'
    $url_extra = 'http://www.jrsoftware.org/download.php/ip015.zip'
    
    return @{
        Version  = $version
        URL32    = $url32
        UrlExtra = $url_extra        
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
