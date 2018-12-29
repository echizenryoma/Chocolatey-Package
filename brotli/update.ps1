Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://github.com"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/google/brotli/releases/latest"
    $version = (($page.Links.href -match "releases/tag/v\d+(\.\d+)+$" | Select-Object -Unique -First 1) -split "/" -match "\d+(\.\d+)+" | Select-Object -First 1).Replace("v", "")

    $url = $base + ($page.Links.href -match "brotli.*win_i686\.zip" | Select-Object -First 1)
    $url64 = $base + ($page.Links.href -match "brotli.*win_x86_64\.zip" | Select-Object -First 1)
    
    if (($url -eq $base) -and ($url64 -eq $base)) {
        $version = "0.0.0"
    }
	
    return @{
        Version = $version
        URL32   = $url
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none