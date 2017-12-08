Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://cn.ezbsystems.com/ultraiso/download.htm"
    $version = ($page.Content -split "<|>" -match "\d+(\.\d+){2,3}" | Get-Unique | Select-Object -First 1).Trim()

    return @{
        Version = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
