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
            "(^[$]JavaVersion\s*=\s*)('.*')"    = "`$1'$($Latest.JavaVersion)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.oracle.com/technetwork/articles/javase/index-jsp-138363.html"
    $url = "http://www.oracle.com/" + ($page.Links | Where-Object outerHTML -Match "Java\s+SE\s+\d+u\d+" | Select-Object -First 1 -ExpandProperty href)
    $html = $page.Links | Where-Object outerHTML -Match "Java\s+SE\s+\d+u\d+" | Select-Object -First 1
    $version = ($html -split "\s|<|>" -match "\d+u\d+").Trim() -replace "u", ".0."
	
    $java_version = "1." + ($version -split "\." | Select-Object -First 1) + ".0_" + ($version -split "\." | Select-Object -Last 1)

    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $html = $page.Content -split "\n|;" -match "jdk-\d+u\d+-windows-i586.exe"
    $json32 = $html -split "=" | Select-Object -Last 1 | ConvertFrom-Json
	
    $html = $page.Content -split "\n|;" -match "jdk-\d+u\d+-windows-x64.exe"
    $json64 = $html -split "=" | Select-Object -Last 1 | ConvertFrom-Json
	
    return @{
        Version        = $version
        URL32          = $json32.filepath -replace "www.oracle.com", "edelivery.oracle.com"
        Checksum32     = $json32.SHA256
        ChecksumType32 = "SHA256"
        URL64          = $json64.filepath -replace "www.oracle.com", "edelivery.oracle.com"
        Checksum64     = $json64.SHA256
        ChecksumType64 = "SHA256"
        JavaVersion    = $java_version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
