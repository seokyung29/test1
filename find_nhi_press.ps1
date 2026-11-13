$url = "https://www.korea.kr/briefing/pressReleaseView.do?newsId=156529328" # 또는 신임관리자 보도자료 검색
# 정책브리핑 검색 API 또는 검색 페이지에서 국가공무원인재개발원 검색
$searchUrl = "https://www.korea.kr/totalSearch/search.do?srchWord=%EA%B5%AD%EA%B0%80%EA%B3%B5%EB%AC%B4%EC%9B%90%EC%9D%B8%EC%9E%AC%EA%B0%9C%EB%B0%9C%EC%9B%90+%EC%8B%A0%EC%9E%84%EA%B4%80%EB%A6%AC%EC%9E%90%EA%B3%BC%EC%A0%95"
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
try {
    $searchHtml = $wc.DownloadString($searchUrl)
    $newsLinks = [regex]::Matches($searchHtml, '/briefing/pressReleaseView\.do\?newsId=\d+') | ForEach-Object { $_.Value } | Select-Object -Unique -First 3
    Write-Host "Found links:" ($newsLinks -join ", ")

    foreach ($link in $newsLinks) {
        $articleUrl = "https://www.korea.kr" + $link
        $artHtml = $wc.DownloadString($articleUrl)
        $imgs = [regex]::Matches($artHtml, 'https://www.korea.kr/newsWeb/resources/attaches/[^"]+\.jpg') | ForEach-Object { $_.Value } | Select-Object -Unique
        Write-Host "In $link found imgs:" ($imgs -join " | ")
        $i = 10
        foreach ($img in $imgs) {
            $outFile = "images/korean_civil_$i.jpg"
            $wc.DownloadFile($img, $outFile)
            Write-Host "Downloaded $outFile ($((Get-Item $outFile).Length) bytes)"
            $i++
        }
    }
} catch {
    Write-Host "Error:" $_.Exception.Message
}
