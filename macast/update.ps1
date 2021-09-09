Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $url = 'https://api.github.com/repos/xfangfang/Macast/releases/latest'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $json = $page.Content | ConvertFrom-Json

    $url = ($json.assets | Where-Object { $_.name -NotMatch "debug" -and $_.name -Match "exe" })[0].browser_download_url
    $version = [version](($json.name -split "_")[0] -split "[a-z]|-" -match "\d" -join ".")
	
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
