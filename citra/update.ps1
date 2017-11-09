Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/citra-emu/citra-nightly/releases/latest"
    $url = "https://github.com" + ($page.Links -match "msvc.*7z" | Select-Object -First 1 -ExpandProperty href)
    $version = ($url -split "/|-" -match "^\d+$") -join "."
	
    return @{
        Version = $version
        URL32     = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none