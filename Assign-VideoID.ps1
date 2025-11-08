param(
    [Parameter(mandatory=$true)][ValidateScript ({Test-Path $_})][string] $PathCSV #Path to MainCSV
)

$MainCSV = Import-Csv -Path $PathCSV -Delimiter ';'
$VideoLinkSource = Import-Csv -Path .\UniqueVideoSources_backup.csv -Delimiter ';' #PathToTheDelimeters

$UniqueVideoLinks = @() #Array of VideoID - Link hashtables

$Incremental = 0 #Increment for VideoID
$FormattedIncremental = "{0:D4}" -f $Incremental #Padding for '0000' formatting


foreach($line in $MainCSV){ #For each line in the Main CSV...

    #$VideoID #The VideoID
    $Diminutive # Diminutive of the VideoID

    

}