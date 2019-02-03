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

function global:au_GetLatest {
    $base = 'https://github.com'
    $page = Invoke-WebRequest -UseBasicParsing -Uri "$base/Genymobile/scrcpy/releases/latest"
    $version = ($page.Links.href -match "releases/tag/v?\d+(\.\d+)+$" | Select-Object -Unique -First 1) -split "/|v" -match "\d+(\.\d+)+" | Select-Object -First 1

    $url32 = $base + ($page.Links.href -match "win32" | Select-Object -First 1)
    $url64 = $base + ($page.Links.href -match "win64" | Select-Object -First 1)

    $checksum_type = 'sha256'
    $url = $base + ($page.Links.href -match "$checksum_type" | Select-Object -First 1)
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $table = [System.Text.Encoding]::UTF8.GetString($page.Content) -split "\n" | ConvertFrom-String -PropertyNames checksum, file
    $checksum32 = $table | Where-Object file -Match "win32" | Select-Object -First 1 -ExpandProperty checksum
    $checksum64 = $table | Where-Object file -Match "win64" | Select-Object -First 1 -ExpandProperty checksum
	
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
