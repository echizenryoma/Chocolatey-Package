Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]Checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
            "(^[$]Version\s*=\s*)('.*')"        = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.oracle.com/technetwork/articles/javase/index-jsp-138363.html"
    $url = "http://www.oracle.com/" + ($page.Links | Where-Object outerHTML -Match "Java\s+SE\s+\d+" | Select-Object -First 1 -ExpandProperty href)

    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
	
    $html = $page.Content -split "\n|;" -match "windows-x64"
    $json64 = $html -split "=" | Select-Object -Last 1 | ConvertFrom-Json

    $url64 = $json64.filepath
    $version = [IO.Path]::GetFileNameWithoutExtension($url64) -split "-|_" -match "^\d+(\.\d+)*" | Select-Object -First 1
    if ($version -notcontains "."){
        $version = $version + ".0.0"
    }
	
    return @{
        Version        = $version
        URL64          = $json64.filepath -replace "download.oracle.com", "edelivery.oracle.com"
        Checksum64     = $json64.SHA256
        ChecksumType64 = 'sha256'
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
