Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_AfterUpdate ($Package) {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.freepascal.org/download.var'
    $version = ($page.Content -split '\s|\n' -match '\<b\>\d+(\.\d+)+\</b\>' | Select-Object -First 1) -split '\s|<|>' -match '\d+(\.\d+)+' | Select-Object -First 1
    $url32 = "https://sourceforge.net/projects/freepascal/files/Win32/${version}/fpc-${version}.i386-win32.exe"
    $url64 = "https://sourceforge.net/projects/freepascal/files/Win32/${version}/fpc-${version}.i386-win32.cross.x86_64-win64.exe"
    
    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
