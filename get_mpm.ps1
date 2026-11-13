$url = "https://www.mpm.go.kr/mpm/info/infoPress/pressNews/?boardId=bbs_0000000000000029&mode=view&cntId=3347"
# mpm 보도자료
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
try {
    $search = $wc.DownloadString("https://www.mpm.go.kr/mpm/comm/totalSearch/?searchKeyword=%EC%8B%A0%EC%9E%84%EA%B4%80%EB%A6%AC%EC%9E%90%EA%B3%BC%EC%A0%95")
    $matches = [regex]::Matches($search, 'cntId=(\d+)') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique -First 3
    Write-Host "Found cntIds:" ($matches -join ", ")
    foreach ($cnt in $matches) {
        $viewUrl = "https://www.mpm.go.kr/mpm/info/infoPress/pressNews/?boardId=bbs_0000000000000029&mode=view&cntId=" + $cnt
        $artHtml = $wc.DownloadString($viewUrl)
        $imgs = [regex]::Matches($artHtml, '(/upload/[^"''\s]+\.(jpg|png|jpeg)|/mpm/comm/fileDownload\.do\?[^"''\s]+)') | ForEach-Object { $_.Value } | Select-Object -Unique
        Write-Host "In cntId $cnt found:" ($imgs -join " | ")
        $k = 1
        foreach ($img in $imgs) {
            $fullUrl = if ($img.StartsWith("http")) { $img } else { "https://www.mpm.go.kr" + $img }
            $wc.DownloadFile($fullUrl, "images/mpm_official_$cnt" + "_$k.jpg")
            Write-Host "Downloaded images/mpm_official_$cnt" + "_$k.jpg"
            $k++
        }
    }
} catch {
    Write-Host "Error:" $_.Exception.Message
}
