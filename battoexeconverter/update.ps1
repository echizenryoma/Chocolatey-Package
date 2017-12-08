Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.f2ko.de/en/b2e.php"
    $md5sum = ($page.Content -split " |<|>" -match "^[a-fA-F0-9]{32,}$" | Select-Object -First 1).Trim()
    $version = ($page.Content -split " |<|>" -match "^\d+(\.\d+){1,}$" | Select-Object -First 1).Trim()
	
    return @{
        Version        = $version
        ChecksumType32 = 'md5'
        Checksum32     = $md5sum
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
