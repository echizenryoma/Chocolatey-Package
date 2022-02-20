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

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://launcher.nirsoft.net/downloads/index.html"
    $ver_re = '\d+(\.\d+)+'
    $url = "https:" + ($page.Links.href -match "nirsoft_package_enc_${ver_re}.zip")[0]
    $version = $url -split "\s|\.zip|_" -match "${ver_re}"
    $sha256_re = '[0-9a-fA-F]{64}'
    $checksum = $page.Links.onclick -match "${sha256_re}" -split "'" -match "${sha256_re}"

    return @{
        Version      = $version
        URL          = $url
        Checksum     = $checksum
        ChecksumType = 'sha256'
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none -NoCheckUrl
