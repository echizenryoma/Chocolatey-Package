Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"            
            "(^[$]Checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]Checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_AfterUpdate ($Package) {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://mkvtoolnix.download/latest-release.xml"
    $xmlObj = [xml]($page.Content)
    $version = $xmlObj.'mkvtoolnix-releases'.'latest-source'.version

    $base = 'https://mkvtoolnix.download/windows/releases'    
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/$version/sha1sums.txt"
    $sha1table = $page.Content -Split '\n' | ConvertFrom-String -PropertyNames sha1sum, file
    $checksum_type = 'sha1'
    $url32 = "${base}/${version}/" + ($sha1table.file -like "*32-bit*7z" | Select-Object -First 1)
    $url64 = "${base}/${version}/" + ($sha1table.file -like "*64-bit*7z" | Select-Object -First 1)
    $checksum32 = $sha1table | Where-Object file -Like "*32-bit*7z" | Select-Object -First 1 -ExpandProperty sha1sum
    $checksum64 = $sha1table | Where-Object file -Like "*64-bit*7z" | Select-Object -First 1 -ExpandProperty sha1sum

    return @{
        Version        = $version
        URL32          = $url32
        URL64          = $url64
        ChecksumType32 = $checksum_type
        Checksum32     = $checksum32
        ChecksumType64 = $checksum_type
        Checksum64     = $checksum64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
