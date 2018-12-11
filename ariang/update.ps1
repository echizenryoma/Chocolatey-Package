Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://github.com"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/mayswind/AriaNg/releases/latest"
    $url = $base + ($page.Links.href -match "\d+(\.\d+).zip" | Select-Object -First 1)
    $version = (($page.Links.href -match "releases/tag/v?\d+(\.\d+)+$" | Select-Object -Unique -First 1) -split "/" -match "\d+(\.\d+)+" | Select-Object -First 1).Replace("v", "")
	
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none