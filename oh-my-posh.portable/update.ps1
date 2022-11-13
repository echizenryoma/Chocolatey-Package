Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"    = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')"    = "`$1'$($Latest.URL64)'"
            "(^[$]UrlExtra\s*=\s*)('.*')" = "`$1'$($Latest.URLExtra)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/JanDeDobbeleer/oh-my-posh/releases/latest"
    $json = $page.Content | ConvertFrom-Json

    $version = $json.tag_name -replace "v", ""
    $url32 = ($json.assets | Where-Object name -Match "windows-386.exe$")[0].browser_download_url
    $url64 = ($json.assets | Where-Object name -Match "windows-amd64.exe$")[0].browser_download_url
    $url_extra = ($json.assets | Where-Object name -Match "themes.zip$")[0].browser_download_url
    
    return @{
        Version  = $version
        URL32    = $url32
        URL64    = $url64
        URLExtra = $url_extra
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
