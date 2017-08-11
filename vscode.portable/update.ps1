Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $url = "https://vscode-update.azurewebsites.net/latest/win32-archive/stable"
    $request = Invoke-WebRequest -Uri $url -MaximumRedirection 0 -ErrorAction Ignore
    $url = $request.Headers.Location
    $version = $url.Substring($url.LastIndexOf("-") + 1).Replace(".zip", "").Trim()

    $url64 = "https://vscode-update.azurewebsites.net/latest/win32-x64-archive/stable"
    $request = Invoke-WebRequest -Uri $url64 -MaximumRedirection 0 -ErrorAction Ignore
    $url64 = $request.Headers.Location
    $version64 = $url.Substring($url64.LastIndexOf("-") + 1).Replace(".zip", "").Trim()

    if ($version -eq $version64) {
        throw "vesion is not matched."
    }

    return @{
        Version = $version
        URL32   = $url
        URL64   = $url64
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
