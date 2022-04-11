Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/Kong/insomnia/releases"
    $json = $page.Content | ConvertFrom-Json
    $version_regex = '\d+(\.\d+)+'
    $json = $json | Where-Object { $_.name -match "Insomnia ${version_regex}" -and $_.name -notmatch "beta" } | Select-Object -First 1

    $version = $json.tag_name -split "@" -match "${version_regex}"
    $url64 = ($json.assets | Where-Object name -Match "\.nupkg")[0].browser_download_url
    
    return @{
        Version = $version
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
