param(
    [Parameter(mandatory=$true)][ValidateScript ({Test-Path $_})][string] $PathCSV
)

$MainCSV = Import-Csv -Path $PathCSV -Delimiter ';'
$UniqueVideoLinks = @{
    
}

foreach($line in $MainCSV){
    Write-Host $line
}
