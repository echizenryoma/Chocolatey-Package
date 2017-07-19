Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]Checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.softwareok.com/?Download=NewFileTime"
    $version = $page -Match "(?<=<title>)([\S\s]*?)(?=</title>)"
    $version = $matches[0].Substring($matches[0].LastIndexOf(" ") + 1).Trim()
	
    return @{
        Version = $version;
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion
