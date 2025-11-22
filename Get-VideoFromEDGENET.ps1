param(
    [Parameter(mandatory=$true)][ValidateScript ({Test-Path $_})][string] $PathCSV, #Path to UniqueDownloadableLinks.csv
    [Parameter(mandatory=$true)][ValidateScript ({Test-Path $_})][string] $OutFilePath #Path to the repertory of downloaded videos
    )

$MainCSV = Import-Csv -Path $PathCSV -Delimiter ';'


foreach ($line in $MainCSV) {
    
   if ((Test-Path "$($OutFilePath)\$($line.VideoID).mp4") -eq $false) {

        try {
            if ($line.VideoID -match "^\d{4}-EDGENET$" ) {
                Invoke-RestMethod -Uri "$($line.DownloadableLink)" -OutFile "$($OutFilePath)\$($line.VideoID).mp4"
                Write-Host $line.VideoID
            } 
        }

        catch {
            Write-Host "Error caught, attempting repair"
            
            try { ## Removes a double-slash sometimes found after the domain
                if ($line.DownloadableLink -match '^https?:\/\/[^\/]+\/\/') {
                        $url = "$($line.DownloadableLink)"
                        $fixed = $url -replace '^(https?:\/\/[^\/]+)\/{2}', '$1/'
                        Write-Host $fixed
                        Invoke-RestMethod -Uri "$fixed" -OutFile "$($OutFilePath)\$($line.VideoID).mp4"
                        Write-Host "$($line.VideoID) doubleslashfixed"
                }
            }
            catch {
                Write-Host "Error with "$line.VideoID""
            }
       }

    }
}