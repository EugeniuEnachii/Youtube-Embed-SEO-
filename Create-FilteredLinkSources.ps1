param(
    [Parameter(mandatory=$true)][ValidateScript ({Test-Path $_})][string] $PathCSV

)

$MainCSV = Import-Csv -Path $PathCSV -Delimiter ';'
$UniqueVideoSources = @()

foreach($line in $MainCSV){
    if ($line.LinkFROriginal -match '^(?:https?:\/\/)?([^\/]+)') {
        $domain = $matches[1]
        $UniqueVideoSources += $domain
    }

    if ($line.LinkENOriginal -match '^(?:https?:\/\/)?([^\/]+)') {
        $domain = $matches[1]
        $UniqueVideoSources += $domain
    }
}

$UniqueVideoSources = $UniqueVideoSources | Sort-Object -Unique
$UniqueVideoSources | ForEach-Object { [PSCustomObject]@{Domain = $_} } | Export-Csv -Path "UniqueVideoSources.csv" -NoTypeInformation -Delimiter ';'

