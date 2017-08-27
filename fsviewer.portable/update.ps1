Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.faststone.org/FSViewerDownload.htm"
    $version = ($page.Content -split "\n|<|>|&" -match "FastStone\s+Image\s+Viewer\s+\d+(\.\d+)+").Trim() -split "\s" -match "^\d+(\.\d+)+$"
    
    $url = $page.Links | Where-Object href -Match "FSViewer\d+.zip" | Select-Object -First 1 -ExpandProperty href

    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
