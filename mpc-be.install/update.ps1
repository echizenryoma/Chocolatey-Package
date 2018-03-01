Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $base = 'https://sourceforge.net/projects/mpcbe/files/MPC-BE/Release%20builds'
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base 
    $version = ($page.Links.href -match "\d+(\.\d+)+/$") -split "/" -match "\d+(\.\d+)+" | Select-Object -First 1
    $url32 = "$base/${version}/MPC-BE.${version}.x86-installer.zip"
    $url64 = "$base/${version}/MPC-BE.${version}.x64-installer.zip"

    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64         
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
