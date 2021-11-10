Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.gyan.dev/ffmpeg/builds/release-version"
    $version = [System.Text.Encoding]::UTF8.GetString($page.Content)
    $url = "https://github.com/GyanD/codexffmpeg/releases/download/${version}/ffmpeg-${version}-full_build-shared.7z"

    return @{ 
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
