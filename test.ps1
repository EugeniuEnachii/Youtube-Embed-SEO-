# Folder containing the videos
$Folder = "C:\Users\BureauVentes8\OneDrive - OUTILLAGE PLACIDE MATHIEU INC\Bureau\DownloadedVideos\All Downloaded Videos"

# Initialize Shell COM object
$shell = New-Object -ComObject Shell.Application
$folderObj = $shell.Namespace($Folder)

# Property index for video width (Frame Width)
$WidthIndex = 182  # Works on modern Windows versions

Get-ChildItem -Path $Folder -File | ForEach-Object {
    $item = $folderObj.ParseName($_.Name)

    # Read width metadata
    $Width = $folderObj.GetDetailsOf($item, $WidthIndex)

    # If metadata exists AND width is not 1920
    if ($Width -and [int]$Width -ne 1920) {
        Write-Host "Not 1920px wide → $($_.Name)"
    }
}
