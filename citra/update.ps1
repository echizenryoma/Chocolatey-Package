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
    $url = $base + "/citra-emu/citra-canary/releases/latest"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $url32 = $base + ($page.Links.href -match "windows-mingw.*7z" | Select-Object -First 1)
    $version = ($url32 -split "/|-" -match "^\d+$") -join "."
	
    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none