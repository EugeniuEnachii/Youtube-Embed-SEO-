# --------- CONFIGURE THESE ----------
$csvPath     = "C:\Users\eugen\OneDrive\Documents\GitHub\Youtube-Embed-SEO-\JSONYoutubeLinks(NoDuplicates).csv"          # <-- set to your CSV path
$videoFolder = "C:\Users\eugen\OneDrive\Desktop\VideosDownloadedVideoID"            # <-- set to your folder with .mp4 files


# Import CSV as proper objects
$videos = Import-Csv -Path $csvPath -Delimiter ";"


foreach ($v in $videos) {

    # Extract VideoID from CSV object
    $videoID = $v.VideoID

    # Extract YouTube ID from the URL
    if ($v.DownloadableLink -match '(?<=v=)[A-Za-z0-9_-]{11}') {
        $ytID = $matches[0]
    }
    else {
        Write-Warning "Could not extract YouTube ID from link: $($v.DownloadableLink)"
        continue
    }

    # Build expected file path
    $oldFile = Join-Path $videoFolder "$ytID.mp4"
    $newFile = Join-Path $videoFolder "$videoID.mp4"

    if (Test-Path $oldFile) {
        Rename-Item -Path $oldFile -NewName "$videoID.mp4"
        Write-Host "Renamed: $ytID.mp4 -> $videoID.mp4"
    }
    else {
        Write-Warning "File not found for YouTube ID: $ytID"
    }
}