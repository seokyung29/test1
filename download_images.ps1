$urls = @(
  "https://www.korea.kr/newsWeb/resources/attaches/2022.09/27/c892c290911d40ff8424b9fcc04a6837.jpg",
  "https://www.korea.kr/newsWeb/resources/attaches/2022.09/27/05_00.jpg",
  "https://www.korea.kr/newsWeb/resources/attaches/2022.09/27/05_01.jpg",
  "https://www.korea.kr/newsWeb/resources/attaches/2025.10/15/9524e8b35c606cd2ab6237fc36e6f668.jpg"
)

$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")

if (-not (Test-Path "images")) {
    New-Item -ItemType Directory -Path "images"
}

$i = 1
foreach ($u in $urls) {
    try {
        $outFile = "images/official_$i.jpg"
        $wc.DownloadFile($u, $outFile)
        Write-Host "Downloaded $outFile ($(Get-Item $outFile).Length bytes)"
        $i++
    } catch {
        Write-Host "Failed: $u"
    }
}
