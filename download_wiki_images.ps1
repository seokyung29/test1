$list = @(
  @{ url = "https://upload.wikimedia.org/wikipedia/commons/7/76/Ministry_of_Personnel_Management_South_Korea.jpg"; file = "images/mpm_building.jpg" },
  @{ url = "https://upload.wikimedia.org/wikipedia/commons/7/7b/Korea_Mexico_Ministerial_Meeting_07_cropped.jpg"; file = "images/korean_ministerial_meeting.jpg" },
  @{ url = "https://upload.wikimedia.org/wikipedia/commons/4/46/KOCIS_Korea_President_Park_Eurasia_Conference_04_%2810452246994%29.jpg"; file = "images/korean_conference.jpg" },
  @{ url = "https://upload.wikimedia.org/wikipedia/commons/9/90/KOCIS_2010_UNESCO_World_Conference_of_Arts_Education_%284641367322%29.jpg"; file = "images/korean_workshop.jpg" }
)

$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
foreach ($item in $list) {
    try {
        $wc.DownloadFile($item.url, $item.file)
        Write-Host "Success: $($item.file) ($((Get-Item $item.file).Length) bytes)"
    } catch {
        Write-Host "Failed: $($item.file) - " $_.Exception.Message
    }
}
