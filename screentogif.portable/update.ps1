Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }

        "screentogif.portable.nuspec"  = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/NickeManarin/ScreenToGif/releases/latest"
    $json = $page.Content | ConvertFrom-Json

    $version = $json.tag_name -replace "v", ""
    $url = ($json.assets | Where-Object name -Match "zip")[0].browser_download_url
    $release_notes = $json.html_url

    return @{
        Version      = $version
        URL32        = $url
        ReleaseNotes = $release_notes
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
