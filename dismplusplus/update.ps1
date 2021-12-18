Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]Url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]Checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/Chuyu-Team/Dism-Multi-language/releases/latest"
    $json = $page.Content | ConvertFrom-Json

    $version = $json.tag_name -replace "v", ""
    $url = ($json.assets | Where-Object name -Match "Dism\+\+")[0].browser_download_url
    
    return @{ 
        Version = $version
        URL     = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
