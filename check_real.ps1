$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
# 위 소스 [3]과 [4]의 리다이렉트 해결 후 이미지 다운로드 시도
# 먼저 정책브리핑 기사에서 이미지 태그 탐색
$urls = @(
    "https://www.korea.kr/briefing/pressReleaseView.do?newsId=156524317",
    "https://www.korea.kr/news/policyNewsView.do?newsId=148905391"
)
foreach ($u in $urls) {
    try {
        $html = $wc.DownloadString($u)
        $imgs = [regex]::Matches($html, 'https://www.korea.kr/newsWeb/resources/attaches/[^"]+\.jpg') | ForEach-Object { $_.Value } | Select-Object -Unique
        Write-Host "In $u found:" ($imgs -join " | ")
        $k = 1
        foreach ($img in $imgs) {
            $outFile = "images/real_ceremony_$k.jpg"
            $wc.DownloadFile($img, $outFile)
            Write-Host "Downloaded $outFile ($((Get-Item $outFile).Length) bytes)"
            $k++
        }
    } catch {
        Write-Host "Error for $u :" $_.Exception.Message
    }
}
