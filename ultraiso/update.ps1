Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.ezbsystems.com/ultraiso/download.htm"
    $version = [version](($page.Content -split "<|>" -match "\d+(\.\d+){2,3}" | Get-Unique | Select-Object -First 1).Trim())
    $url = "http://reg.ezbsys.com/private/3939p575/uiso$($version.Major)$($version.Minor)pes.exe"

    return @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
