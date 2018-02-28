Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.advancedrenamer.com/download"
    $version = (($page.Links | Where-Object class -Match "btn_download" | Select-Object -First 1 -ExpandProperty title) -split "\s" -match "\d+(\.\d+)+" | Select-Object -First 1).Trim()
       
    return @{
        Version = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
