Import-Module AU

function global:au_SearchReplace {
  @{
    'tools\ChocolateyInstall.ps1'   = @{
      "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
    }
    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }
  }
}

function global:au_GetLatest {
  $base_url = "https://sourceforge.net"
  $url = "${base_url}/projects/maxima/files/Maxima-Windows"
  $page = Invoke-WebRequest -Uri $url -UseBasicParsing

  $re = '[\d\.]+\-Windows\/$'
  $url = $base_url + ($page.Links.href -match $re)[0]
  $page = Invoke-WebRequest -Uri $url -UseBasicParsing
  $re = '\d+(\.\d+)+'
  $version = ($url -split "/|-" -match "$re")[0]

  $re = 'win32\.exe\/download$'
  $url32 = ($page.Links.href -match $re)[0]

  $re = 'win64\.exe\/download$'
  $url64 = ($page.Links.href -match $re)[0]

  $release_notes = "${base_url}/p/maxima/code/ci/master/tree/changelogs/ChangeLog-${version}.md"

  return  @{
    URL32        = $url32
    URL64        = $url64
    Version      = $version
    ReleaseNotes = $release_notes
  }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
