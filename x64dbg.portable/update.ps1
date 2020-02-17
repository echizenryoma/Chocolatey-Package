Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
    }
}

function global:au_AfterUpdate ($Package) {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $base = "https://sourceforge.net/projects/x64dbg/files/snapshots/"
    $page = Invoke-WebRequest -UseBasicParsing -Uri $base
    $url32 = ($page.Links.href -match "snapshot_.*\/download")[0] -replace "/download", ""
    $version = ([IO.Path]::GetFileNameWithoutExtension($url32) -split "\.|_" -match "\d+(-\d+)+$" -Replace "-", "" | Select-Object -First 2) -join "."
	
    return @{
        Version = $version
        URL32   = $url32
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
