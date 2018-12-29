Import-Module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.nirsoft.net/utils/wifi_information_view.html"
    $version = ($page -split "\n|<|>" -match "WifiInfoView\s+v\d+\.\d+" | Select-Object -First 1) -split "\s|v" -match "\d+(\.\d+)+" | Select-Object -First 1

    return @{
        Version = $version
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
