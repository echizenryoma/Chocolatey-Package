Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $url = 'https://api.github.com/repos/rizonesoft/Notepad3/releases/latest'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $json = $page.Content | ConvertFrom-Json

    $url32 = ($json.assets | Where-Object { $_.name -match "zip" -and $_.name -notmatch "Setup" })[0].browser_download_url
    $version = [version](($json.name -split "_" -match "\d+(\.\d+)+")[0])
	
    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none