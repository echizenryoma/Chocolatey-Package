Import-Module AU

function global:au_SearchReplace {
    @{
        
    }
}
function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'http://ngwin.com/picpick/download'
    $version = ($page.Content -split '\n|<|>|\s' -match 'v\d+(\.\d+)+' | Select-Object -First 1).Replace("v", "")

    return @{ 
        Version = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
