Import-Module AU

function global:au_SearchReplace {
    @{
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://jrsoftware.org/isdl.php"
    $version = (($page.Content -split '<|>' -match 'innosetup-\d+(\.\d+)+.exe') -split '-|.exe' -match '\d+(\.\d+)')[0]

    return @{
        Version = $version
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
