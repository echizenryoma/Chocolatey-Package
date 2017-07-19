Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $url =  "https://vscode-update.azurewebsites.net/latest/win32-archive/stable"
    $request = Invoke-WebRequest -Uri $url -MaximumRedirection 0 -ErrorAction Ignore
    $url =  $request.Headers.Location
    $version = $url.Substring($url.LastIndexOf("-") + 1).Replace(".zip", "").Trim()

    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
