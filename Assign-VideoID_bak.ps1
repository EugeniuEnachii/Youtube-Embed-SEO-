param(
    [Parameter(mandatory=$true)][ValidateScript ({Test-Path $_})][string] $PathCSV
)

$MainCSV = Import-Csv -Path $PathCSV -Delimiter ';'
$VideoLinkSource = Import-Csv -Path .\UniqueVideoSources_backup.csv -Delimiter ';'

$UniqueVideoLinks = @()
[int]$Incremental = 0
$FormattedIncremental = "{0:D4}" -f $Incremental

foreach($line in $MainCSV){
    $Incremental = $Incremental + 1
    $FormattedIncremental = "{0:D4}" -f $Incremental
    $VideoID
    $Diminutive

    # Extract domain from the link
    if ($line.LinkFROriginal -match '^(?:https?:\/\/)?([^\/]+)') {
        $domain = $matches[1] 
        
    # Check if the domain exists in the CSV
        $entry = $VideoLinkSource | Where-Object { $_.Domain -eq $domain } 
        
        if ($entry) {
            $Diminutive = $entry.Diminutive  # Writes the stuff
            $VideoID =  "$FormattedIncremental-$Diminutive"
            
            #Write-Host $VideoID
        }

        if (($UniqueVideoLinks | Where-Object { $_.Link -eq $line.LinkFROriginal })) {
        
        }
    }


    
    
    

    
}










