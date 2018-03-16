$LinkPath = Join-Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) "PicPick.lnk"
Remove-Item $LinkPath -Force -ErrorAction Ignore