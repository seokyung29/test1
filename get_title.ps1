$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
$html = $wc.DownloadString("https://www.korea.kr/news/policyNewsView.do?newsId=148906371")
[regex]::Matches($html, '<h[1-3][^>]*>(.*?)</h[1-3]>') | ForEach-Object { $_.Groups[1].Value }
[regex]::Matches($html, '(?i)<img[^>]+src="[^"]*(c892c290911d40ff8424b9fcc04a6837|05_00|05_01)[^"]*"[^>]*>') | ForEach-Object { $_.Value }
