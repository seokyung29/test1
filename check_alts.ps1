$url = "https://www.korea.kr/news/policyNewsView.do?newsId=148906371"
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
$html = $wc.DownloadString($url)
[regex]::Matches($html, '<img[^>]+src="([^">]+)"[^>]*alt="([^">]*)"') | ForEach-Object {
    [PSCustomObject]@{
        Src = $_.Groups[1].Value
        Alt = $_.Groups[2].Value
    }
} | Format-Table -Wrap
