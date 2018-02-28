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
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.sandboxie.com/AllVersions'
    $version = $page.Content -split '\n|<|>' -match '^\d+(\.\d+)+$' | Select-Object -First 1
    $url32 = "https://www.sandboxie.com/" + ($page.Links.href -match 'SandboxieInstall-\d+\.exe$' | Select-Object -First 1)
    $checksum = ($page.Content -split '\n|<|>' -match 'SHA1\s+[0-9a-fA-F]{40}' | Select-Object -First 1).Trim() | ConvertFrom-String -PropertyNames ChecksumType, Checksum
    
    return @{
        URL32          = $url32
        Checksum32     = $checksum.Checksum
        ChecksumType32 = $checksum.ChecksumType
        Version        = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
