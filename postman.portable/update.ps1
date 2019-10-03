Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
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

    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://dl.pstmn.io/RELEASES?platform=win32"
    $obj32 = ($page.Content | ConvertFrom-Json).releases | Select-Object -Last 1
    $url32 = $obj32.files | Where-Object url -Match "full.nupkg" | Select-Object -First 1 -ExpandProperty url
    $checksum32 = $obj32.files | Where-Object url -Match "full.nupkg" | Select-Object -First 1 -ExpandProperty hash
    $version32 = $obj32.name

    if ($version32 -ne $version64) {
        throw "32-bit and 64-bit version do not match. Please investigate."
    }
    $version = $version64
    
    return @{
        Version        = $version
        URL32          = $url32
        Checksum32     = $checksum32
        ChecksumType32 = $checksum_type
        URL64          = $url64
        Checksum64     = $checksum64
        ChecksumType64 = $checksum_type
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
