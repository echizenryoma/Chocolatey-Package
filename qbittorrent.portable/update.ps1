import-module AU

function global:au_SearchReplace {
    @{
        "tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $releases = 'http://www.qbittorrent.org/download.php'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $releases 

    $urls = $page.Links.href -match 'setup\.exe\/download$' | Select-Object -First 2
    $url32 = $urls -notmatch "x64" | Select-Object -first 1
    $url64 = $urls -match "x64" | Select-Object -first 1

    $version = $url32 -split '[_]' | Select-Object -Last 1 -Skip 1
    $version64 = $url64 -split '[_]' | Select-Object -Last 1 -Skip 2
    if ($version -ne $version64) {
        throw "32-bit and 64-bit version do not match. Please investigate."
    }

    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
