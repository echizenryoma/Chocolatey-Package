﻿Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Checksum32\s*=\s*)('.*')"        = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')"    = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]Checksum64\s*=\s*)('.*')"        = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')"    = "`$1'$($Latest.ChecksumType64)'"
            "(^[$]ChecksumExtra\s*=\s*)('.*')"     = "`$1'$($Latest.ChecksumExtra)'"
            "(^[$]ChecksumTypeExtra\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumTypeExtra)'"
        }
    }
}

function global:au_AfterUpdate ($Package) {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.softwareok.com/?Download=NewFileTime"
    $version = $page -Match "(?<=<title>)([\S\s]*?)(?=</title>)"
    $version = $matches[0] -split "\s" -match "\d+(\.\d+)+"

    $checksum_type = 'sha256'

    $sha256sum = ($page.Links.href -match "[0-9a-fA-f]{64,}") -split "/" -match "[0-9a-fA-f]{64,}"
    $checksum32 = $sha256sum[0]
    $checksum64 = $sha256sum[4]
    $checksum_extra = $sha256sum[2]
    
    return @{
        Version           = $version
        Checksum32        = $checksum32
        ChecksumType32    = $checksum_type
        Checksum64        = $checksum64
        ChecksumType64    = $checksum_type
        ChecksumExtra     = $checksum_extra
        ChecksumTypeExtra = $checksum_type
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
