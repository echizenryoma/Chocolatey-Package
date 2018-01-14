Import-Module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $request = Invoke-WebRequest -Uri "https://www.netsarang.com/beta/download.php?id=xsh" -MaximumRedirection 0 -ErrorAction Ignore
    $url = $request.Headers.Location
    $version = ($url -split "/" | Select-Object -Last 1) -split "-|r" -match "\d+(\.\d+)+" | Select-Object -First 1

    return @{
        Version = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
