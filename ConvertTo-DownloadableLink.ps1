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

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=  

        { $_ -in "assets.edgenet.com" } {
            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = $line.Link
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   

        { $_ -in "milwaukeetool.widen.net" } {
            function Get-1080pLink { 
                param([string]$Url)
                $r = Invoke-WebRequest $Url
                $pattern = '"label":\s*"1080p".*?"source":\s*"([^"]+)"'
                [regex]::Matches($r.Content, $pattern, 'Singleline') |
                ForEach-Object { $_.Groups[1].Value }
            }

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   

            $VideoLinkWiden = Get-1080pLink "https://milwaukeetool.widen.net/s/w2l7zpqct2/milwaukeer-jobsite-lighti"

            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = $VideoLinkWiden
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   

        { $_ -in "milwaukeetool.widencollective.com" } {
            function Get-1080pLink { 
                param([string]$Url)
                $r = Invoke-WebRequest $Url
                $pattern = '"label":\s*"1080p".*?"source":\s*"([^"]+)"'
                [regex]::Matches($r.Content, $pattern, 'Singleline') |
                ForEach-Object { $_.Groups[1].Value }
            }

            $VideoLinkWiden = Get-1080pLink "https://milwaukeetool.widen.net/s/w2l7zpqct2/milwaukeer-jobsite-lighti"

            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = "$VideoLinkWiden"
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   

        { $_ -in "milwaukeetoolca.smugmug.com" } {
            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = "TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO "
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   

        { $_ -in "p.widencdn.net" } {
            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = "Dead Link"
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   

        { $_ -in "p1.aprimocdn.net" } {
            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = "Dead Link"
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   

        { $_ -in "player.vimeo.com" } {
            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = "TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO "
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   

        { $_ -in "players.brightcove.net" } {
            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = "Dead Link"
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   

        { $_ -in "vimeo.com" } {
            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = "TO DO TO DO TO DO TO DO TO DO TO DO TO DO TO DO "
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }

# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   

        { $_ -in "youtu.be" } {
            if ($line.Link -match '(?:embed\/|v=|youtu\.be/)([A-Za-z0-9_-]{11})') {
                $YoutubeVideoID = $matches[1]

                $Appendable = [PSCustomObject]@{
                    VideoID = $line.VideoID
                    Link = $line.Link
                    DownloadableLink = "https://www.youtube.com/watch?v=$YoutubeVideoID"
                }

                $NewCSVOfDownloadableLinks += $Appendable
            }
        }

        { $_ -in "0" } {
            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = "ZERO"
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }
        
        default {
            Write-Host $domain "some other stuff some other stuff some other stuff some other stuff some other stuff some other stuff "

            $Appendable = [PSCustomObject]@{
                VideoID = $line.VideoID
                Link = $line.Link
                DownloadableLink = "$domain some other stuff some other stuff some other stuff some other stuff some other stuff some other stuff "
            }

            $NewCSVOfDownloadableLinks += $Appendable
        }

}
}

#$NewCSVOfDownloadableLinks | Where-Object -Property VideoID -Match "wide" | Select-Object -Property DownloadableLink
$NewCSVOfDownloadableLinks | Export-Csv "UniqueDownloadableLinks.csv" -Delimiter ';' -NoTypeInformation