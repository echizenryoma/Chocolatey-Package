Import-Module AU

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]Url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]Checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]ChecksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $url = 'https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe'
    $file = Join-Path $PSScriptRoot $([IO.Path]::GetFileName($url))

    Write-Host "Downloading full setup file to find the version"
    Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $file
    $version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($file).FileVersion
    $hash = Get-FileHash $file
    Remove-Item $file -Force -ErrorAction Ignore

    @{
        Version        = $version
        URL32          = $url
        Checksum32     = $hash.Hash
        ChecksumType32 = $hash.Algorithm
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
