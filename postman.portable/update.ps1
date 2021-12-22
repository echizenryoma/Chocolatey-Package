Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]Checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $checksum_type = 'sha1'

    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://dl.pstmn.io/RELEASES?platform=win64"
    $obj64 = ($page.Content | ConvertFrom-Json).releases | Select-Object -Last 1
    $url64 = $obj64.files | Where-Object url -Match "full.nupkg" | Select-Object -First 1 -ExpandProperty url
    $checksum64 = $obj64.files | Where-Object url -Match "full.nupkg" | Select-Object -First 1 -ExpandProperty hash
    $version64 = $obj64.name
 
    return @{
        Version        = $version64
        URL64          = $url64
        Checksum64     = $checksum64
        ChecksumType64 = $checksum_type
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
