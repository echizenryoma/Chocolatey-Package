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
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/citra-emu/citra-canary/releases/latest"
    $url = $base + ($page.Links.href -match "windows-mingw.*7z" | Select-Object -First 1)
    $version = ($url -split "/|-" -match "^\d+$") -join "."
	
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none