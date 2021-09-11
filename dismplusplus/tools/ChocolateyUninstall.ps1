$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "Dism++.lnk"
Remove-Item -Path $LinkPath -Force -ErrorAction Ignore