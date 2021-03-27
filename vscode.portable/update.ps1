Import-Module AU

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

function global:au_AfterUpdate ($Package) {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $url32 = 'https://update.code.visualstudio.com/api/update/win32-archive/stable/VERSION'
    $url64 = 'https://update.code.visualstudio.com/api/update/win32-x64-archive/stable/VERSION'

    $json32 = Invoke-WebRequest -UseBasicParsing -Uri $url32 | ConvertFrom-Json
    $json64 = Invoke-WebRequest -UseBasicParsing -Uri $url64 | ConvertFrom-Json

    if ($json32.productVersion -ne $json64.productVersion) {
        throw "Different versions for 32-Bit and 64-Bit detected."
    }

    $version = $json64.productVersion

    $url32 = "https://update.code.visualstudio.com/${version}/win32-archive/stable"
    $url64 = "https://update.code.visualstudio.com/${version}/win32-x64-archive/stable"
    $checksum_type = 'sha256'

    return @{
        Version        = $version
        URL32          = $url32
        ChecksumType32 = $checksum_type
        Checksum32     = $json32.sha256hash
        URL64          = $url64
        ChecksumType64 = $checksum_type
        Checksum64     = $json64.sha256hash
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
