Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
        }
    }
}

function global:au_AfterUpdate ($Package) {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/SubtitleEdit/subtitleedit/releases/latest"
    $json = $page.Content | ConvertFrom-Json

    $version = $json.tag_name -replace "v", ""
    $url = ($json.assets | Where-Object name -Match "\.zip")[0].browser_download_url
    
    return @{
        Version = $version
        URL     = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
