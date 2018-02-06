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
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.imagemagick.org/download/binaries/digest.rdf'
    $file32 = ([xml]$page.Content).RDF.Content | Where-Object about -Match "portable.*x86" | Select-Object -Last 1
    $file64 = ([xml]$page.Content).RDF.Content | Where-Object about -Match "portable.*x64" | Select-Object -Last 1

    $null = ($file32 | Where-Object about -Match "x86"| Select-Object -First 1 -ExpandProperty about) -match "\d+(\.\d+)+\-\d+"
    $version = $Matches[0].Replace('-', '.')

    $url32 = "https://www.imagemagick.org/download/binaries/" + $file32.about
    $url64 = "https://www.imagemagick.org/download/binaries/" + $file64.about

    $checksum32 = $file32.sha256
    $checksum64 = $file64.sha256

    return @{ 
        URL32          = $url32
        Checksum32     = $checksum32
        ChecksumType32 = 'sha256'
        URL64          = $url64
        Checksum64     = $checksum64
        ChecksumType64 = 'sha256'
        Version        = $version 
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none