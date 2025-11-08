param(
    [Parameter(mandatory=$true)][ValidateScript ({Test-Path $_})][string] $PathCSV #Path to MainCSV
)

$MainCSV = Import-Csv -Path $PathCSV -Delimiter ';'
$VideoLinkSource = Import-Csv -Path .\UniqueVideoSources_backup.csv -Delimiter ';' #PathToTheDelimeters

$UniqueVideoLinks = @()        # Array of VideoID - Link hashtables

$Incremental = 0                # Increment for VideoID
$FormattedIncremental           # Padding for '0000' formatting


foreach($line in $MainCSV){     # For each line in the Main CSV...

    $VideoID               = "" # The VideoID (ex : 0001-YOUTUBE)
    $Diminutive            = "" # Diminutive of the VideoID (ex : YOUTUBE)
    $Domain                = "" # Link related to the diminutive (ex : www.youtube.com)
    $AppendableHashtable   = "" # It's a hashtable that will get appended to $UniqueVideoLinks (ex : @{VideoID = "0001-YOUTUBE" ; Link = "www.youtube.com/watch?v=akjsKdSKJakah" })


# =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^= a  =^..^=   =^..^=   =^..^=    =^..^=    =^..^=    =^..^=   
    

    if($line.LinkFROriginal -match '^(?:https?:\/\/)?([^\/]+)') {

        if($line.LinkFROriginal -notin ($UniqueVideoLinks.Link)){
            $Domain = $matches[1] #Gives a source link (www.youtube.com)
            $entry = $VideoLinkSource | Where-Object { $_.Domain -eq $domain } # Hashtable (@{Domain=milwaukeetool.widen.net; Diminutive=WIDENNET})
            $Diminutive = $entry.Diminutive
            
            $Incremental++ #Increment for VideoID
            $FormattedIncremental = "{0:D4}" -f $Incremental #Updates the incremental formatting

            $VideoID = "$FormattedIncremental-$Diminutive"
            
            $AppendableHashtable = [PSCustomObject]@{VideoID = "$VideoID" ; Link = "$($line.LinkFROriginal)"} 
            $UniqueVideoLinks += $AppendableHashtable
        }    
    }

    if($line.LinkENOriginal -match '^(?:https?:\/\/)?([^\/]+)') {

        if($line.LinkENOriginal -notin ($UniqueVideoLinks.Link)){
            $Domain = $matches[1] #Gives a source link (www.youtube.com)
            $entry = $VideoLinkSource | Where-Object { $_.Domain -eq $domain } # Hashtable (@{Domain=milwaukeetool.widen.net; Diminutive=WIDENNET})
            $Diminutive = $entry.Diminutive
            
            $Incremental++ #Increment for VideoID
            $FormattedIncremental = "{0:D4}" -f $Incremental #Updates the incremental formatting

            $VideoID = "$FormattedIncremental-$Diminutive"
            
            $AppendableHashtable = [PSCustomObject]@{VideoID = "$VideoID" ; Link = "$($line.LinkENOriginal)"} 
            $UniqueVideoLinks += $AppendableHashtable
        }    
    }
    
}
$UniqueVideoLinks