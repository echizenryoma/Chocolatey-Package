Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri 'https://www.python.org/downloads'
    $url = $page.Links.href -match '.exe' | Select-Object -First 1
    $version = [IO.Path]::GetFileNameWithoutExtension($url) -split '-' -match "\d+(\.\d+)+" | Select-Object -First 1

    return @{
        Version = $version 
        URL32   = $url
        URL64   = $url -replace '.exe', '-amd64.exe'
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
