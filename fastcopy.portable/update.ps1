Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://fastcopy.jp"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/en"
    $url = $base + ($page.Links.href -match "_installer\.exe" | Select-Object -First 1)
    $version = ($page.Content -split "\n|<|>" -match "Download\s+v\d+(\.\d+)+") -split "\s|v" -match "^\d+(\.\d+)+$"
		
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
