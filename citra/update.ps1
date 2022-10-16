Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/citra-emu/citra-canary/releases/latest"
    $json = $page.Content | ConvertFrom-Json

    $url = ($json.assets | Where-Object name -Match "windows-mingw.*7z$")[0].browser_download_url
    $version = ($url -split "/|-" -match "^\d+$") -join "."
    
    return @{
        Version = $version
        URL     = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none