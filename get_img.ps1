$url = "https://www.korea.kr/news/policyNewsView.do?newsId=148906371"
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
try {
    $html = $wc.DownloadString($url)
    $matches = [regex]::Matches($html, 'https://www.korea.kr/newsWeb/resources/attaches/[^"]+\.jpg')
    $matches | ForEach-Object { $_.Value } | Select-Object -Unique | Out-File -FilePath "images.txt"
    Write-Host "Success! Found:" $matches.Count
} catch {
    Write-Host "Error:" $_.Exception.Message
}
