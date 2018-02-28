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

function global:au_AfterUpdate ($Package)  {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html"
    $html = $page.Content -split "\n|;" -match "windows-x64\.exe"
    $json64 = $html -split "=" | Select-Object -Last 1 | ConvertFrom-Json
    $java_version = ($json64.filepath -split "/|-" -match "\d+u\d+" | Select-Object -First 1).Trim()
    $version = $java_version -replace "u", ".0."
    
    $html = $page.Content -split "\n|;" -match "windows-i.*\.exe"
    $json32 = $html -split "=" | Select-Object -Last 1 | ConvertFrom-Json
	
    return @{
        Version        = $version
        URL32          = $json32.filepath -replace "download.oracle.com", "edelivery.oracle.com"
        Checksum32     = $json32.SHA256
        ChecksumType32 = "SHA256"
        URL64          = $json64.filepath -replace "download.oracle.com", "edelivery.oracle.com"
        Checksum64     = $json64.SHA256
        ChecksumType64 = "SHA256"
        JavaVersion    = $java_version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
