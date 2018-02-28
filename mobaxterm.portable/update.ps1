Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"  
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://mobaxterm.mobatek.net/download-home-edition.html"
    $url = $page.Links | Where-Object {$_.href -Match 'v\d+(\.\d+)+\.zip' -and $_.outerHTML -match 'Portable\s+edition'} | Select-Object -First 1 -ExpandProperty href
    $version = [IO.Path]::GetFileNameWithoutExtension($url) -split '_|v' -match '\d+(\.\d+)+' | Select-Object -First 1
    
    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -ChecksumFor none
