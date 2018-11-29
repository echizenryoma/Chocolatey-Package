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
    $base = 'https://www.navicat.com.cn'

    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/download/navicat-premium" -SessionVariable session

    $url32 = $base + ($page.Links.href -Match "x86\.exe" | Select-Object -First 1)
    $url64 = $base + ($page.Links.href -Match "x64\.exe" | Select-Object -First 1)

    $content = $url32 -split "\?" | Select-Object -Last 1
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/includes/Navicat/direct_download.php" -Method Post -Body $content -WebSession $session
    $json32 = $page.Content | ConvertFrom-Json
    $url32 = "http://" + $json32.download_link

    $content = $url64 -split "\?" | Select-Object -Last 1
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/includes/Navicat/direct_download.php" -Method Post -Headers $headers -Body $content -WebSession $session
    $json64 = $page.Content | ConvertFrom-Json
    $url64 = "https://" + $json64.download_link

    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/products/navicat-premium-release-note"
    $version = ($page.Content -split "`n|<|>" -match 'Navicat.*version\s+\d+(\.\d+)+$' | Select-Object -First 1) -split "\s" -match '\d+(\.\d+)+$' | Select-Object -First 1
    
    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
