Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
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
    $url64 = ($json.assets | Where-Object { $_.name -Match "zip" -and $_.name -Match "x64"})[0].browser_download_url
    $url32 = ($json.assets | Where-Object { $_.name -Match "zip" -and $_.name -Match "x86"})[0].browser_download_url
    $release_notes = $json.html_url

    return @{
        Version      = $version
        URL32        = $url32
        URL64        = $url64
        ReleaseNotes = $release_notes
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
