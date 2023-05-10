Import-Module AU

function global:au_SearchReplace {
    @{
    }
}

function global:au_AfterUpdate ($Package) {
    $global:Options.Push = $true
}

function global:au_GetLatest {
    $url = 'https://ipfs.io/ipfs/QmPBp7wBSC9GukPUcp7LXFCGXBvc2e45PUfWUbCJzuLG65?filename=Bat_To_Exe_Converter.zip'
    $dir = Join-Path "$Env:TMP" "choco\battoexeconverter"
    $file = Join-Path "$dir" "Bat_To_Exe_Converter.zip"
    $null = New-Item -Path $dir -ItemType Directory
    Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $file
    Expand-Archive $file -DestinationPath $dir
    $version = (Get-ChildItem -Path $dir -File -Filter "*.exe" -Exclude "*Setup*", "*Installer*" -Recurse)[0].VersionInfo.FileVersionRaw

    return @{
        Version = $version
    }
}

Update-Package -NoCheckChocoVersion -ChecksumFor none
