Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
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
    $base = "https://qemu.weilnetz.de/w64/"
    $checksum_type = "sha512"

    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $file64 = ($page.Links.href -match '.exe$' | Select-Object -Last 1)
    $url64 = $base + $file64

    $date = $file64 -split "-|\." -match "^\d+$"
    $version = $date.substring(0, 4) + "." + $date.substring(4, 2) + "." + $date.substring(6, 2)

    $url = $base + $([IO.Path]::GetFileNameWithoutExtension($file64)) + "." + $checksum_type
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $checksum64 = [System.Text.Encoding]::UTF8.GetString($page.Content) -split "\s" | Select-Object -First 1
    
    $url = $url.Replace('64', '32')
    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $checksum32 = [System.Text.Encoding]::UTF8.GetString($page.Content) -split "\s" | Select-Object -First 1

    $url32 = $url64.Replace('64', '32')

    return @{
        Version        = $version
        URL32          = $url32
        ChecksumType32 = $checksum_type
        Checksum32     = $checksum32
        URL64          = $url64
        ChecksumType64 = $checksum_type
        Checksum64     = $checksum64
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
