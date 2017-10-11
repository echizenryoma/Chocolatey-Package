Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://nodejs.org/en/download/"
    $url = $page.links | Where-Object href -match ".zip$" | Select-Object -First 1 -ExpandProperty href
    $version = ($url -split "v|/" -match "^\d+(\.\d+)+$" | Select-Object -First 1).Trim()
    
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://npm.taobao.org/mirrors/node/v${version}/SHASUMS256.txt"
    $shasums = $page.Content -split "\n" | ConvertFrom-String -PropertyNames SHA256, File

    return @{
        Version        = $version
        URL32          = "https://npm.taobao.org/mirrors/node/v${version}/node-v${version}-win-x86.7z"
        Checksum32     = $shasums | Where-Object File -Match "win-x86.7z$" | Select-Object -First 1 -ExpandProperty SHA256
        ChecksumType32 = 'sha256'
        URL64          = "https://npm.taobao.org/mirrors/node/v${version}/node-v${version}-win-x64.7z"
        Checksum64     = $shasums | Where-Object File -Match "win-x64.7z$" | Select-Object -First 1 -ExpandProperty SHA256
        ChecksumType64 = 'sha256'
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
