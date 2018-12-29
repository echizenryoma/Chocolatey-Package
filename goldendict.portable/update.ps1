Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/goldendict/goldendict/wiki/Early-Access-Builds-for-Windows'
    $url32 = ($page.Links -match "Qt\s+\d(\.\d)+\-based\s+build\s+\(7z\)" | Select-Object -First 1).href
    $url64 = ($page.Links -match "Qt\s+\d(\.\d)+\-based\s+64\-bit\s+build\s+\(7z\)" | Select-Object -First 1).href
    $version = ($url32 -split "/|_" -match "GoldenDict-\d+(\.\d+)+" | Select-Object -First 1).Replace("-RC", ".") -split "-" -match "^\d+" -join ""
    
    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
