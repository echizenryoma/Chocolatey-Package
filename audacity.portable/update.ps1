import-module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $url = 'https://www.fosshub.com/Audacity.html'
    $page = Invoke-WebRequest -Uri $url
    $obj = ($page.Scripts.outerText -match "settings") -split "=" -match "{" | ConvertFrom-Json
    $file = ($obj.pool.f -match "zip" -notmatch "manual")[0]
    $checksum_type = 'sha256'
    $checksum = $file.hash.$checksum_type
    $version = $file.n -split "-|\.zip" -match "\d+(\.\d+)+"

    return @{
        Version        = $version
        ChecksumType32 = $checksum_type
        Checksum32     = $checksum
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
