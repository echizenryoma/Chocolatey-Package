Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/chocolatey/ChocolateyGUI/releases/latest"
    $json = $page.Content | ConvertFrom-Json

    $version = $json.tag_name -replace "v", ""
    $url = ($json.assets | Where-Object name -Match "\.msi")[0].browser_download_url
    
    return @{
        Version = $version
        URL     = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
