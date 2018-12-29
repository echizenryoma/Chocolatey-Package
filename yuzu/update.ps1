Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $base = "https://github.com"
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/yuzu-emu/yuzu-canary/releases/latest"
    $url64 = "https://github.com" + ($page.Links.href -match "windows-mingw.*7z" | Select-Object -First 1)
    $version = ($url64 -split "/|-" -match "^\d+$") -join "."
	
    return @{
        Version = $version
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none