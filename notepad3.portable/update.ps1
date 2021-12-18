Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $url = 'https://api.github.com/repos/rizonesoft/Notepad3/releases/latest'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $json = $page.Content | ConvertFrom-Json

    $url32 = ($json.assets | Where-Object { $_.name -match "x86" -and $_.name -match "zip" -and $_.name -notmatch "Setup" })[0].browser_download_url
    $url64 = ($json.assets | Where-Object { $_.name -match "x64" -and $_.name -match "zip" -and $_.name -notmatch "Setup" })[0].browser_download_url
    $version = [version](($json.name -split "_" -match "\d+(\.\d+)+")[0])

    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none