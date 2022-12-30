import-module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]Checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $url = 'https://www.fosshub.com/Audacity.html'
    $page = Invoke-WebRequest -Uri $url -UseBasicParsing
    $obj = ($page.Content -split "\n" -match "var settings") -split "=" -match "{" | ConvertFrom-Json
    $file32 = ($obj.pool.f -match "zip" -match "x32" -match "win" -notmatch "manual")[0]
    $checksum_type = 'sha256'
    $checksum32 = $file32.hash.$checksum_type
    $version32 = $file32.n -split "-|\.zip" -match "\d+(\.\d+)+"
    $file64 = ($obj.pool.f -match "zip" -match "x64" -match "win" -notmatch "manual")[0]
    $checksum64 = $file64.hash.$checksum_type
    $version64 = $file64.n -split "-|\.zip" -match "\d+(\.\d+)+"

    if ($version64 -ne $version32) {
        Write-Error "Audacity version mismatch: $version32 vs $version64"
    }
    $version = $version64

    return @{
        Version        = $version
        ChecksumType32 = $checksum_type
        Checksum32     = $checksum32
        ChecksumType64 = $checksum_type
        Checksum64     = $checksum64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
