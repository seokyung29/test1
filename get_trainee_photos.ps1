$url = "https://www.korea.kr/news/policyNewsView.do?newsId=148906371" # 제67기 수료식 기사
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
$html = $wc.DownloadString($url)

# 기사 본문 내 이미지 URL 찾기
$matches = [regex]::Matches($html, 'https://www.korea.kr/newsWeb/resources/attaches/[^"]+\.jpg')
Write-Host "Matches found:" $matches.Count
$idx = 1
foreach ($m in $matches) {
    $u = $m.Value
    if ($u -like "*2022.09*") {
        $outFile = "images/trainee_real_$idx.jpg"
        $wc.DownloadFile($u, $outFile)
        Write-Host "Downloaded $u to $outFile ($((Get-Item $outFile).Length) bytes)"
        $idx++
    }
}
