Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'http://adoxa.altervista.org/global/'
    $version = $page.Content -split '\s|\n|<|>' -match '^\d+(\.\d+)+$' | Select-Object -First 1
    $url = "http://adoxa.altervista.org/global/dl.php?f=win32"
    
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
