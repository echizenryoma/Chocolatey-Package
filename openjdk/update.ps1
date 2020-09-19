Import-Module AU

function global:au_SearchReplace {
    @{
    }
}

function global:au_GetLatest {
    $base = 'https://jdk.java.net'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $url = $base + ($page.Links -match "JDK\s+\d+")[0].href

    $page = Invoke-WebRequest -UseBasicParsing -Uri $url
    $url64 = ($page.Links.href -match "windows.*zip$")[0]
    $version = ($url64 -split '/|_' -match '^openjdk-\d+(\.\d+)*$')[0] -replace "openjdk-",""
    $dot_count = 2 - ($version.ToCharArray() | Where-Object {$_ -eq '.'} | Measure-Object).Count
    $version = $version + (".0" * $dot_count)

    return @{
        Version = $version
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
