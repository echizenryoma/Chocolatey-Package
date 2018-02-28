Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
        }
    }
}

function global:au_AfterUpdate ($Package)  {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $request = Invoke-WebRequest -Uri "https://vscode-update.azurewebsites.net/latest/win32-archive/stable" -MaximumRedirection 0 -ErrorAction Ignore
    $url = $request.Headers.Location
    $version = $([IO.Path]::GetFileNameWithoutExtension($url)) -split "-" -match "\d+(\.\d+)+" | Select-Object -First 1

    return @{
        Version = $version
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
