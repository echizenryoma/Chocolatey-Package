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
    $global:Latest.URL32 = $url
    
    Write-Host "Downloading full setup file to find the version"
    Get-RemoteFiles -Purge -NoSuffix
    
    $file_path = [IO.Path]::Combine($PSScriptRoot, 'tools', "$([IO.Path]::GetFileName($url))")
    $version = [version]([System.Diagnostics.FileVersionInfo]::GetVersionInfo($file_path).FileVersion)

    Remove-Item -Path $file_path -Force

    return @{
        Version = $version
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
