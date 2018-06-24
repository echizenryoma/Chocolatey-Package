Import-Module AU

function global:au_SearchReplace {
    @{}
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'http://www.picpick.org/update.html'
    $version = ($page.Content -split '\s' -match '\d+(\.\d+)*' | Select-Object -First 1).Insert(1, ".").Insert(3, ".").Insert(5, ".")

    return @{ 
        Version = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
