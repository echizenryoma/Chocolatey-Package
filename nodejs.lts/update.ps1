Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
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
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://nodejs.org/en/download/"
    $url = $page.Links.href -match ".zip$" | Select-Object -First 1
    $version = [IO.Path]::GetFileNameWithoutExtension($url) -split "v|-" -match "^\d+(\.\d+)+$" | Select-Object -First 1
    
    $url32 = "https://npm.taobao.org/mirrors/node/v${version}/node-v${version}-win-x86.7z"
    $url64 = "https://npm.taobao.org/mirrors/node/v${version}/node-v${version}-win-x64.7z"

    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://npm.taobao.org/mirrors/node/v${version}/SHASUMS256.txt"
    $obj = $page.Content -split "\n" | ConvertFrom-String -PropertyNames sha256, file
    $checksum_type = 'sha256'
    $checksum32 = $obj | Where-Object file -Match "win-x86.7z$" | Select-Object -First 1 -ExpandProperty sha256
    $checksum64 = $obj | Where-Object file -Match "win-x64.7z$" | Select-Object -First 1 -ExpandProperty sha256

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

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
