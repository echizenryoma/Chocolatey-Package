Import-Module AU

function global:au_SearchReplace {
  @{
    ".\tools\ChocolateyInstall.ps1" = @{
      "(^[$]Url32\s*=\s*)('.*')" = "`${1}'$($Latest.URL32)'"
    }

    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_GetLatest {
  $url = 'https://nmap.org/download.html'
  $page = Invoke-WebRequest -Uri $url -UseBasicParsing

  $url32 = $page.links.href -match '\.zip$' -notmatch 'BETA'
  $version = $url32 -split '/|-' -match '\d+(\.\d+)+'

  return  @{
    URL32        = $url32
    Version      = $version
    ReleaseNotes = "https://nmap.org/changelog.html#${version}"
  }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
