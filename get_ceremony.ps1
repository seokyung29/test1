$u = "https://www.korea.kr/news/policyNewsView.do?pWise=sub&pWiseMain=F1&newsId=148905391"
# 신임관리자과정 수료식 기사 URL 찾기
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
$search = $wc.DownloadString("https://www.google.com/search?q=site:korea.kr+%EC%A0%9C67%EA%B8%B0+%EC%8B%A0%EC%9E%84%EA%B4%80%EB%A6%AC%EC%9E%90%EA%B3%BC%EC%A0%95+%EC%88%98%EB%A3%8C%EC%8B%9D")
$links = [regex]::Matches($search, 'https://www\.korea\.kr/news/policyNewsView\.do\?newsId=\d+') | ForEach-Object { $_.Value } | Select-Object -Unique
Write-Host "Found:" ($links -join ", ")

foreach ($l in $links) {
    $art = $wc.DownloadString($l)
    $imgs = [regex]::Matches($art, 'https://www.korea.kr/newsWeb/resources/attaches/[^"]+\.jpg') | ForEach-Object { $_.Value } | Select-Object -Unique
    Write-Host "Images in $l :" ($imgs -join " | ")
    $k = 1
    foreach ($img in $imgs) {
        $wc.DownloadFile($img, "images/trainee_ceremony_$k.jpg")
        Write-Host "Saved images/trainee_ceremony_$k.jpg ($((Get-Item images/trainee_ceremony_$k.jpg).Length) bytes)"
        $k++
    }
}
