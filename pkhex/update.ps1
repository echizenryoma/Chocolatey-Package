Import-Module AU

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri "https://projectpokemon.org/forums/files/file/1-pkhex/"
    $version = ($page.Links | Where-Object outerHTML -Match "\d+(\.\d+){1,4}" | Select-Object -First 1 -ExpandProperty outerHTML).Trim()
    $version = $version -split "<|>" -match "^\d+(\.\d+){1,4}$"
	
    return @{
        Version = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
