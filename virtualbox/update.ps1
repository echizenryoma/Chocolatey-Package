Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')"             = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')"             = "`$1'$($Latest.URL64)'"
            "(^[$]Checksum32\s*=\s*)('.*')"        = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')"    = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]Checksum64\s*=\s*)('.*')"        = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')"    = "`$1'$($Latest.ChecksumType64)'"
            "(^[$]UrlExtra\s*=\s*)('.*')"          = "`$1'$($Latest.URL_Extra)'"
            "(^[$]ChecksumExtra\s*=\s*)('.*')"     = "`$1'$($Latest.ChecksumExtra)'"
            "(^[$]ChecksumTypeExtra\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumTypeExtra)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.virtualbox.org/wiki/Downloads"
    $url = $page.Links -match "VirtualBox-\d+(\.\d+){1,}-\d+-Win\.exe" | Select-Object -First 1 -ExpandProperty href
    $version = $url -split '/' -match '^\d+(\.\d+){1,}$' | Select-Object -First 1

    $url = "http://download.virtualbox.org/virtualbox/${version}/"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $url = $page.Links | Where-Object href -Match "Win" | Select-Object -First 1 -ExpandProperty href
    $url = "http://download.virtualbox.org/virtualbox/${version}/" + $url
    $url_extra = "http://download.virtualbox.org/virtualbox/${version}/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack"
    
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://download.virtualbox.org/virtualbox/${version}/SHA256SUMS"
    $sha256sums = $page.Content -split '\n' -replace "\*", '' | ConvertFrom-String -PropertyNames SHA256SUM, FileName
      
    return @{
        URL32             = $url
        Checksum32        = $sha256sums -match "\-Win\.exe" | Select-Object -First 1 -ExpandProperty SHA256SUM
        ChecksumType32    = 'SHA256'
        URL64             = $url
        Checksum64        = $sha256sums -match "\-Win\.exe" | Select-Object -First 1 -ExpandProperty SHA256SUM
        ChecksumType64    = 'SHA256'
        URL_Extra         = $url_extra
        ChecksumExtra     = $sha256sums -match "\.vbox-extpack" | Select-Object -First 1 -ExpandProperty SHA256SUM
        ChecksumTypeExtra = 'SHA256'
        Version           = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
