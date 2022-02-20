Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url\s*=\s*)('.*')"          = "`$1'$($Latest.URL)'"
            "(^[$]Checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum)'"
            "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType)'"
        }
    }
}

function global:au_BeforeUpdate() {
    $Headers = @{
        Referer = 'https://launcher.nirsoft.net/'
    }
    $Latest.Checksum = Get-RemoteChecksum -Url $Latest.Url -Algorithm $Latest.ChecksumType -Headers $Headers
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://launcher.nirsoft.net/downloads/index.html"
    $ver_re = '\d+(\.\d+)+'
    $version = ($page.Links.href -match "${ver_re}" -split "/|\.zip|_" -match "${ver_re}")[0]
    $url = 'https://download.nirsoft.net/nirsoft_package_schinese.zip'

    return @{
        Version      = $version
        URL          = $url
        ChecksumType = 'sha256'
    }
}

Update-Package -NoCheckChocoVersion -NoCheckUrl -ChecksumFor none

