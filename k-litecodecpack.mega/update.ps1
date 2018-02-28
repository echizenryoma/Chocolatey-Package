Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'http://www.codecguide.com/download_k-lite_codec_pack_mega.htm'
    $version = ($page.Content -split '\n|<|>|~' -match 'Version\s+\d+(\.\d+)+\s+Mega' | Select-Object -First 1).Trim() -split '\s' -match '\d+(\.\d+)+' | Select-Object -First 1
    $url32 = $page.Links.href -match 'K-Lite_Codec_Pack_\d+_Mega.exe$' | Select-Object -First 1
    $sha256sum32 = $page.Content -split '\n|<|>|~|:|\s' -match '[0-9a-fA-F]{64}' | Select-Object -First 1
    
    return @{
        URL32          = $url32
        Checksum32     = $sha256sum32
        ChecksumType32 = 'sha256'
        Version        = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
