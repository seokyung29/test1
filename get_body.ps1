$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
$html = $wc.DownloadString("https://www.korea.kr/news/policyNewsView.do?newsId=148906371")
$matches = [regex]::Matches($html, '(?s)<div class="article-content".*?</div>')
foreach ($m in $matches) {
    Write-Host $m.Value.Substring(0, [Math]::Min(1000, $m.Value.Length))
}
