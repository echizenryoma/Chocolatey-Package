Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://api.github.com/repos/xiaoyifang/goldendict/releases/latest"
    $json = $page.Content | ConvertFrom-Json

    $url64 = ($json.assets | Where-Object name -Match "GoldenDict.exe.*windows.*.zip$")[0].browser_download_url
    $version = ($json.name -split "/|-|v" -match "^\d+(\.\d+)+$")[0] + "." + ($json.name -split "\." -match "^\d{6}$")

    return @{
        Version = $version
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
