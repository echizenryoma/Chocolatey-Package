Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"
    $json = $page.Content | ConvertFrom-Json

    $version = $json.tag_name -replace "v", ""
    $url32 = ($json.assets | Where-Object name -Match "DejaVuSansMono")[0].browser_download_url
    
    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
