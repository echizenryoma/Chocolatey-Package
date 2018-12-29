import-module AU

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
    $base = "https://www.imagemagick.org/download/binaries"

    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/digest.rdf"
    $file32 = ([xml]$page.Content).RDF.Content | Where-Object about -Match "portable.*x86" | Select-Object -Last 1
    $file64 = ([xml]$page.Content).RDF.Content | Where-Object about -Match "portable.*x64" | Select-Object -Last 1

    $null = $file32.about -match "\d+(\.\d+)+\-\d+"
    $version = $Matches[0].Replace('-', '.')

    $checksum_type = 'sha256'

    $url32 = "${base}/$($file32.about)"
    $url64 = "${base}/$($file64.about)"

    $checksum32 = $file32.sha256
    $checksum64 = $file64.sha256

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