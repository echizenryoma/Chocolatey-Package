﻿Import-Module AU

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
    $base = 'https://www.voidtools.com'
    $page = Invoke-WebRequest -UseBasicParsing -Uri "${base}/downloads/"
    $url32 = $base + ($page.Links.href -match "x86.zip" | Select-Object -First 1)
    $url64 = $base + ($page.Links.href -match "x64.zip" | Select-Object -First 1)
    $version = $url32 -split "/|-|\.x" -match '\d(\.\d+)+' | Select-Object -First 1

    $checksum_type = 'sha256'
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://www.voidtools.com/Everything-${version}.${checksum_type}"
    $table = [System.Text.Encoding]::UTF8.GetString($page.Content) -split "\n" | ConvertFrom-String -PropertyNames checksum, file
    $checksum32 = $table | Where-Object file -Match "x86.zip" | Select-Object -First 1 -ExpandProperty checksum
    $checksum64 = $table | Where-Object file -Match "x64.zip" | Select-Object -First 1 -ExpandProperty checksum

    return @{
        Version        = $version
        URL32          = $url32
        URL64          = $url64
        Checksum32     = $checksum32
        ChecksumType32 = $checksum_type
        Checksum64     = $checksum64
        ChecksumType64 = $checksum_type
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
