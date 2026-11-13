$u = "https://www.korea.kr/briefing/pressReleaseView.do?newsId=156524317"
# 소스 [2] 주소 확인
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
# HWP 또는 첨부파일 확인
$html = $wc.DownloadString("https://www.korea.kr/briefing/pressReleaseView.do?newsId=156524317")
$files = [regex]::Matches($html, 'href="([^"]+fileDownload[^"]+)"') | ForEach-Object { $_.Groups[1].Value }
Write-Host "Files:" ($files -join " | ")
