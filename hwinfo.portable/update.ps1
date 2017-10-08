Import-Module au



function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(?i)(^\s*[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.hwinfo.com/ver.txt'
    $html = $page.Content -split '\n' -match '\d+'  | Select-Object -Unique | Sort-Object -Descending
    $version = $html | Select-Object -First 1
    $url_version = ($version -split '-' | Select-Object -First 1).Replace('.', '')
    $version = $version.Replace('-', '.').Trim()

    return @{ 
        Version = $version
        URL32   = "https://www.hwinfo.com/files/hw32_$url_version.zip"
        URL64   = "https://www.hwinfo.com/files/hw64_$url_version.zip"
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
