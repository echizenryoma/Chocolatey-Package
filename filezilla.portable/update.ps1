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
    $url = 'https://filezilla-project.org/download.php?show_all=1'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $url32 = $page.Links.href -match "win32\.zip" | Select-Object -First 1
    $url64 = $page.Links.href -match "win64\.zip" | Select-Object -First 1
    $version = $url32 -split '_' -match '^\d+\.[\d\.]+$' | Select-Object -First 1

    $checksum_type = 'sha512'
    $url = $page.Links.href -match "${checksum_type}" | Select-Object -First 1
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $table = [System.Text.Encoding]::UTF8.GetString($page.Content) -split "\n" | ConvertFrom-String -PropertyNames checksum, file
    $checksum32 = $table | Where-Object file -Match "win32\.zip" | Select-Object -First 1 -ExpandProperty checksum
    $checksum64 = $table | Where-Object file -Match "win64\.zip" | Select-Object -First 1 -ExpandProperty checksum

    @{
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
