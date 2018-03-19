Import-Module AU

function global:au_SearchReplace {
    @{}
}
function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://projectpokemon.org/forums/files/file/1-pkhex/"
    $version = ($page.Links | Where-Object outerHTML -Match "\d+(\.\d+){1,4}" | Select-Object -First 1 -ExpandProperty title) -split "\s" -match "^\d+(\.\d+)+" | Select-Object -First 1
	
    return @{
        Version = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
