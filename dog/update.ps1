Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/ogham/dog/releases/latest"
    $json = $page.Content | ConvertFrom-Json

    $version = $json.tag_name -replace "v", ""
    $url64 = ($json.assets | Where-Object { $_.name -Match "windows" -and $_.name -NotContains "minisig"})[0].browser_download_url

    return @{
        Version = $version
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
