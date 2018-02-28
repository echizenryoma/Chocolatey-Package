Import-Module AU

function global:au_SearchReplace {
    [version]$version = $Latest.Version | Select-Object -First 1
    $docsUrl = "http://tomcat.apache.org/tomcat-$($version.Major).$($version.Minor)-doc/index.html"


    @{
        ".\tools\ChocolateyInstall.ps1" = @{
            "(^[$]Url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]Url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
        "tomcat.portable.nuspec"        = @{
            "(?i)(^\s*\<docsUrl\>).*(\<\/docsUrl\>)" = "`${1}$docsUrl`${2}"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -UseBasicParsing -Uri 'http://tomcat.apache.org/'
    $version = [version](($page.Content -split '\n|<|>|\(|\)' -match "Tomcat\s+\d+(\.\d+)+\s+Released" | Select-Object -First 1) -split "\s" -match '\d+(\.\d+)+' | Select-Object -First 1)

    $url32 = "https://mirrors.ustc.edu.cn/apache/tomcat/tomcat-$($version.Major)/v${version}/bin/apache-tomcat-${version}-windows-x86.zip"
    $url64 = "https://mirrors.ustc.edu.cn/apache/tomcat/tomcat-$($version.Major)/v${version}/bin/apache-tomcat-${version}-windows-x64.zip"

    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64        
    }
}

Update-Package -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
