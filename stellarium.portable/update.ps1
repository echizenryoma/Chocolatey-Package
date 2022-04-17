Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/Stellarium/stellarium/releases/latest"
    $json = $page.Content | ConvertFrom-Json
    $version_regex = '\d+(\.\d+)+'
    $version = $json.tag_name -split "v" -match "${version_regex}"
    $url32 = ($json.assets | Where-Object name -Match "win32.exe")[0].browser_download_url
    $url64 = ($json.assets | Where-Object name -Match "win64.exe")[0].browser_download_url
    
    return @{
        Version = $version
        URL     = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
