Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri "https://github.com/upx/upx/tags"
    $version = ($page.Links | Where-Object innerText -Match "^v\d+(\.\d+){1,2}" | Select-Object -First 1 -Expand innerText).Replace("v", "").Trim()
    $url = "https://github.com/upx/upx/releases/download/v${version}/upx$($version.Replace(".", ''))w.zip"
    
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
