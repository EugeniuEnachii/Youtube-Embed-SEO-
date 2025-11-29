## Path to your CSV containing a column named "VideoID"
#$PathCSV = ".\videos.csv"
#
## Load list of video IDs
#$videos = Import-Csv $PathCSV
#
## Your API key
#$ApiKey = "AIzaSyBYn7M--4x1W0qJwzgirjHvZcI7aMVIeyU"
#
## Prepare result list
#$Results = @()
#
## YouTube allows 50 IDs at a time
#$BatchSize = 50
#$Total = $videos.Count
#
#For ($i=0; $i -lt $Total; $i += $BatchSize) {
#
#    $Batch = $videos[$i..([math]::Min($i + $BatchSize - 1, $Total - 1))]
#
#    $IDs = ($Batch.VideoID -join ",")
#
#    $Url = "https://www.googleapis.com/youtube/v3/videos?part=status&id=$IDs&key=$ApiKey"
#
#    try {
#        $Response = Invoke-RestMethod -Uri $Url -Method Get
#    }
#    catch {
#        Write-Host "API error on batch starting at index $i"
#        continue
#    }
#
#    # Found videos
#    foreach ($item in $Response.items) {
#        $Results += [PSCustomObject]@{
#            VideoID = $item.id
#            Status  = $item.status.privacyStatus  # public/private/unlisted
#            Exists  = "Yes"
#        }
#    }
#
#    # Missing videos (deleted or removed)
#    $FoundIDs = $Response.items.id
#    $Missing = $Batch | Where-Object { $_.VideoID -notin $FoundIDs }
#
#    foreach ($m in $Missing) {
#        $Results += [PSCustomObject]@{
#            VideoID = $m.VideoID
#            Status  = "deleted_or_unavailable"
#            Exists  = "No"
#        }
#    }
#}
#
## Export results
#$Results | Export-Csv -Path ".\VideoStatusResults.csv" -NoTypeInformation -Delimiter ";"
#
#Write-Host "Done! Results saved to VideoStatusResults.csv"    




$PathCSV = ".\videos.csv"
$videos = Import-Csv $PathCSV

$ApiKey = "AIzaSyBYn7M--4x1W0qJwzgirjHvZcI7aMVIeyU"
$Results = @()
$BatchSize = 50
$Total = $videos.Count

for ($i = 0; $i -lt $Total; $i += $BatchSize) {

    $Batch = $videos[$i..([math]::Min($i + $BatchSize - 1, $Total - 1))]
    $IDs = ($Batch.VideoID -join ",")

    $Url = "https://www.googleapis.com/youtube/v3/videos?part=status,snippet&id=$IDs&key=$($ApiKey)"

    try { $Response = Invoke-RestMethod $Url }
    catch { continue }

    # Found items
    foreach ($item in $Response.items) {

        $uploadStatus = $item.status.uploadStatus
        $privacy = $item.status.privacyStatus

        $realStatus = switch ($uploadStatus) {
            "processed" { $privacy }             # public/private/unlisted
            "deleted"   { "deleted" }
            "rejected"  { "blocked_or_unavailable" }
            "failed"    { "failed" }
            default     { $uploadStatus }
        }

        $Results += [PSCustomObject]@{
            VideoID      = $item.id
            APIStatus    = $uploadStatus
            Privacy      = $privacy
            FinalStatus  = $realStatus
        }
    }

    # Missing videos → deleted or removed
    $Found = $Response.items.id
    $Missing = $Batch | Where-Object { $_.VideoID -notin $Found }

    foreach ($m in $Missing) {
        $Results += [PSCustomObject]@{
            VideoID      = $m.VideoID
            APIStatus    = "not_found"
            Privacy      = ""
            FinalStatus  = "deleted_or_unavailable"
        }
    }
}

$Results | Export-Csv ".\VideoStatusResults.csv" -NoTypeInformation -Delimiter ";"