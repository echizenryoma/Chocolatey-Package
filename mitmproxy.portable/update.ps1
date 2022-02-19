Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
        }
        ".\mitmproxy.portable.nuspec"   = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`$1'$($Latest.ReleaseNotes)'`$2"
        }
    }
}

function global:au_GetLatest {
    $url = 'https://api.github.com/repos/mitmproxy/mitmproxy/releases/latest'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $json = $page.Content | ConvertFrom-Json

    $version = [version](($json.name -split "_")[0] -split "[a-z]| - " -match "\d" -join ".")
    $url = "https://snapshots.mitmproxy.org/${version}/mitmproxy-${version}-windows.zip"
    $release_notes = "https://github.com/mitmproxy/mitmproxy/releases/tag/v${version}"

    return @{
        Version      = $version
        URL          = $url
        ReleaseNotes = $release_notes
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
