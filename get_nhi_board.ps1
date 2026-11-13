$url = "https://www.nhi.go.kr/nhi/selectBbsNttList.do?bbsNo=42"
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
try {
    $html = $wc.DownloadString($url)
    Write-Host "Length:" $html.Length
    [regex]::Matches($html, '(/upload/[^"''\s]+\.(jpg|png|jpeg)|/common/fileDownload\.do\?[^"''\s]+)') | ForEach-Object { $_.Value } | Select-Object -Unique | Select-Object -First 10
} catch {
    Write-Host "Error:" $_.Exception.Message
}
