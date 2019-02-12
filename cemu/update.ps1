Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://cemu.info"
    $url64 = $page.Links | Where-Object name -eq "download" | Select-Object -First 1 -ExpandProperty href
    $version = (($page.Links | Where-Object name -eq "download" | Select-Object -First 1 -ExpandProperty outerHTML) -split "\s|_|\(|\)|," -match "v\d+(\.\d+)+" | Select-Object -First 1) -replace "v", ''
    $rev = ([byte][char]$version[$version.Length - 1]) - [byte][char]'a' + 1
    $version = $version -replace "[a-z]", ".$rev"
	
    return @{
        Version = $version
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none