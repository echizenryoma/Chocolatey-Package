import-module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1'   = @{
            "(^[$]Url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]Url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]Checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $base = 'https://inkscape.org'
    $url = "${base}/release/"
    $request = Invoke-WebRequest -UseBasicParsing -Uri $url -MaximumRedirection 0 -ErrorAction Ignore

    $release_url = $base + $request.Headers.Location
    $version = $release_url -split '\/(inkscape-)?' -match '\d+(\.\d+)+' | Select-Object -First 1

    $page32 = Invoke-WebRequest -UseBasicParsing -Uri "$release_url/windows/32-bit/binary-7z/dl/"
    $page64 = Invoke-WebRequest -UseBasicParsing -Uri "$release_url/windows/64-bit/binary-7z/dl/"
    $url32 = $base + ($page32.Links.href -match "\.7z$" | Select-Object -First 1)
    $url64 = $base + ($page64.Links.href -match "\.7z$" | Select-Object -First 1)

    $checksum_type = 'md5'
    $checksum32_url = $page32.Links.href -match "${checksum_type}$" | Select-Object -First 1
    $checksum64_url = $page64.Links.href -match "${checksum_type}$" | Select-Object -First 1
    $page32 = Invoke-WebRequest -UseBasicParsing -Uri $checksum32_url
    $page64 = Invoke-WebRequest -UseBasicParsing -Uri $checksum64_url
    $table32 = [System.Text.Encoding]::UTF8.GetString($page32.Content) -split "\n" | ConvertFrom-String -PropertyNames checksum, file
    $table64 = [System.Text.Encoding]::UTF8.GetString($page64.Content) -split "\n" | ConvertFrom-String -PropertyNames checksum, file
    $checksum32 = $table32 | Where-Object file -Match "x86" | Select-Object -First 1 -ExpandProperty checksum
    $checksum64 = $table64 | Where-Object file -Match "x64" | Select-Object -First 1 -ExpandProperty checksum

    @{
        Version        = $version
        URL32          = $url32
        Checksum32     = $checksum32
        ChecksumType32 = $checksum_type
        URL64          = $url64
        Checksum64     = $checksum64
        ChecksumType64 = $checksum_type
        ReleaseNotes   = $release_url + "#left-column"
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none