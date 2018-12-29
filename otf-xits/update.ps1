Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://ctan.org/pkg/xits"
    $version = ($page.Content -split "<|>|`n" -match "^\d+(\.\d+)+" | Select-Object -First 1).Trim() -replace "\s", "." -replace "\-", ""
    $url32 = $page.Links -match "Down&shy;load" | Select-Object -First 1 -ExpandProperty href
    
    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
