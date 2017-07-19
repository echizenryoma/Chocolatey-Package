Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
        }
    }
}
function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://digi.bib.uni-mannheim.de/tesseract/?C=M;O=D"
    $Url =  'https://digi.bib.uni-mannheim.de/tesseract/' + ($page.Links | Where-Object {$_.href -NotMatch "dev" -And $_.href -Match "\d+(\.\d+)+-.*\.exe"} | Select-Object -ExpandProperty href -First 1)
    $version = $url -split "-|\.exe" -match "\d+(\.\d+)*" -join '.'

    return @{
        URL     = $url
        Version = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
