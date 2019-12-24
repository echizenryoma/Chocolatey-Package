Import-Module AU

function global:au_SearchReplace {
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://wincontig.mdtzone.it/en/index.htm"
    $version = ($page -split "\n|<|>" -match "WinContig\s+\d+(\.\d+)+" | Select-Object -First 1) -split "\s|v" -match "\d+(\.\d+)+" | Select-Object -First 1

    return @{
        Version = $version
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
