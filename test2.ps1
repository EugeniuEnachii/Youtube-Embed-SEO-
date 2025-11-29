$FolderPath = "C:\Users\eugen\OneDrive\Desktop\VideosDownloadedVideoID"
$CSVPath = "C:\Users\eugen\OneDrive\Desktop\Github\AdventOfCode2024\Youtube-Embed-SEO-\videos.csv"

# Import CSV
$csv = Import-Csv $CSVPath

# Get all filenames (without extension) from folder
$folderFiles = Get-ChildItem $FolderPath -File | Select-Object -ExpandProperty BaseName

# Compare
$missing = $csv.VideoID | Where-Object { $_ -notin $folderFiles }

# Output missing ones
$missing