param(
    [Parameter(mandatory=$true)][ValidateScript ({Test-Path $_})][string] $PathCSV #Path to MainCSV
)

$MainCSV = Import-Csv -Path $PathCSV -Delimiter ';'
$NewCSVOfDownloadableLinks = @()

foreach ($line in $MainCSV) {

    $domain = $null
    

    if ($line.Link -match '^(?:https?:\/\/)?([^\/]+)') {
        $domain = $matches[1] 
    } 


    switch ($domain) {

        { $_ -in "www.youtube.com"}{

            if ($line.Link -match '(?:embed\/|v=)([A-Za-z0-9_-]{11})') {
                $YoutubeVideoID = $matches[1]

                $Appendable = [PSCustomObject]@{
                    VideoID = $line.VideoID
                    Link = $line.Link
                    DownloadableLink = "https://www.youtube.com/watch?v=$YoutubeVideoID"
                }

                $NewCSVOfDownloadableLinks += $Appendable
            }
        
        }

        { $_ -in "assets.edgenet.com" } {
            Write-Host "Edgenet Link"
        }

        { $_ -in "milwaukeetool.widen.net" } {
            Write-Host "Widennet Link"
        }

        { $_ -in "milwaukeetool.widencollective.com" } {
            Write-Host "Widencollective Link"
        }

        { $_ -in "milwaukeetoolca.smugmug.com" } {
            Write-Host "Smugmug Link"
        }

        { $_ -in "p.widencdn.net" } {
            Write-Host "Widencdn Link"
        }

        { $_ -in "p1.aprimocdn.net" } {
            Write-Host "Aprimocdn Link"
        }

        { $_ -in "player.vimeo.com" } {
            Write-Host "PLAYERVIMEO Link"
        }

        { $_ -in "players.brightcove.net" } {
            Write-Host "Brightcove Link"
        }

        { $_ -in "vimeo.com" } {
            Write-Host "Vimeo Link"
        }

        { $_ -in "youtu.be" } {
            Write-Host "Youtu-be Link"
        }

        { $_ -in "0" } {
            Write-Host "ZERO"
        }
        
        default {
            Write-Host $domain "some other stuff some other stuff some other stuff some other stuff some other stuff some other stuff "
        }

}
}

$NewCSVOfDownloadableLinks
$NewCSVOfDownloadableLinks | Export-Csv "TESTATEFTSFEAT.csv" -Delimiter ';' -NoTypeInformation