Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://github.com"
    $release_url = "${base}/DoubleLabyrinth/navicat-keygen/releases/latest"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $release_url
    $version = ($page.Links.href -match "releases/tag/.*\d+(\.\d+)+$" | Select-Object -Unique -First 1) -split "/|v" -match "\d+(\.\d+)+" | Select-Object -First 1
    $url32 = $base + ($page.Links.href -match "x86\.zip" | Select-Object -First 1)
    $url64 = $base + ($page.Links.href -match "x64\.zip" | Select-Object -First 1)

    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
